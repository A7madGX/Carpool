import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/date_parser.dart';
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/model/trip.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddTripBottom extends StatefulWidget {
  const AddTripBottom({super.key});

  @override
  State<AddTripBottom> createState() => _AddTripBottomState();
}

class _AddTripBottomState extends State<AddTripBottom> {
  bool fromASU = true;
  bool isAM = true;
  String gateNumber = 'Gate 1';
  DateTime? chosenDate;
  late TextEditingController locationCtrl;
  late TextEditingController priceCtrl;

  @override
  void initState() {
    locationCtrl = TextEditingController();
    priceCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    locationCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, stateCtrl, _) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          width: 0.95.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 150.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: LightTheme.greyTheme,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fromASU = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightTheme.backgroundTheme,
                        side: BorderSide(
                          color: fromASU ? LightTheme.mainTheme : LightTheme.secondaryfontTheme,
                        ),
                        fixedSize: Size(125.w, 25.h),
                      ),
                      child: Text(
                        'From ASU',
                        style: TextStyle(
                          color: fromASU ? LightTheme.mainTheme : LightTheme.fontTheme,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fromASU = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightTheme.backgroundTheme,
                        side: BorderSide(
                          color: fromASU ? LightTheme.secondaryfontTheme : LightTheme.mainTheme,
                        ),
                        fixedSize: Size(125.w, 25.h),
                      ),
                      child: Text(
                        'To ASU',
                        style: TextStyle(
                          color: fromASU ? LightTheme.fontTheme : LightTheme.mainTheme,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                5.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fromASU ? 'PickUp' : 'Destination',
                        style: TextStyle(
                          color: LightTheme.secondaryfontTheme,
                        ),
                      ),
                      DropdownButton(
                        borderRadius: BorderRadius.circular(20.r),
                        dropdownColor: LightTheme.backgroundTheme,
                        value: gateNumber,
                        style: TextStyle(
                          color: LightTheme.secondaryfontTheme,
                        ),
                        items: const <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                            value: 'Gate 1',
                            child: Text('Gate 1'),
                          ),
                          DropdownMenuItem(
                            value: 'Gate 2',
                            child: Text('Gate 2'),
                          ),
                          DropdownMenuItem(
                            value: 'Gate 3',
                            child: Text('Gate 3'),
                          ),
                          DropdownMenuItem(
                            value: 'Gate 4',
                            child: Text('Gate 4'),
                          ),
                        ],
                        onChanged: (val) {
                          setState(() {
                            gateNumber = val!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                5.verticalSpace,
                TextField(
                  controller: locationCtrl,
                  decoration: InputDecoration(
                    labelText: fromASU ? 'Destination' : 'PickUp',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
                10.verticalSpace,
                TextField(
                  controller: priceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    10.horizontalSpace,
                    Text(
                      'PickUp Date',
                      style: TextStyle(
                        color: LightTheme.secondaryfontTheme,
                      ),
                    ),
                    15.horizontalSpace,
                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: LightTheme.secondaryfontTheme,
                          )),
                      child: Text(
                        (chosenDate != null)
                            ? getTripDate(fromASU: fromASU, dateTime: chosenDate!)
                            : getInitialTripDate(fromASU: fromASU),
                        style: TextStyle(
                          color: LightTheme.secondaryfontTheme,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        chosenDate = await showDatePicker(
                          context: context,
                          initialDate: strToDate(getInitialTripDate(fromASU: fromASU)),
                          firstDate: strToDate(getInitialTripDate(fromASU: fromASU)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        setState(() {});
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
                10.verticalSpace,
                ElevatedButton(
                  onPressed: () {
                    if (locationCtrl.text.isEmpty || priceCtrl.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: LightTheme.backgroundTheme,
                          title: const Text('Empty field(s)'),
                          content: const Text('Please complete all the information'),
                          contentTextStyle: TextStyle(
                            color: LightTheme.secondaryfontTheme,
                          ),
                        ),
                      );
                      return;
                    }
                    final tripDate = (chosenDate != null)
                        ? getTripDate(fromASU: fromASU, dateTime: chosenDate!)
                        : getInitialTripDate(fromASU: fromASU);
                    final locFromDropButton = 'ASUFE - $gateNumber';
                    final newTrip = Trip(
                      driverName: stateCtrl.myFetchedInfo.name,
                      price: int.parse(priceCtrl.text),
                      pickUpLocation: fromASU ? locFromDropButton : locationCtrl.text,
                      destination: fromASU ? locationCtrl.text : locFromDropButton,
                      tripDate: tripDate,
                      status: TripStatus.pending,
                    );
                    UserService.addTrip(newTrip);
                    AwesomeDialog(
                      buttonsTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                      dialogBackgroundColor: LightTheme.backgroundTheme,
                      btnOkColor: LightTheme.mainTheme,
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'Trip Added Successfully',
                      desc: 'A Notification will be sent shortly..',
                      btnOkOnPress: () {
                        stateCtrl.reloadMyTrips();
                        Navigator.of(context).pop();
                      },
                    ).show();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightTheme.mainTheme,
                    fixedSize: Size(1.sw, 30.h),
                  ),
                  child: Text(
                    'Add Trip',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: LightTheme.backgroundTheme,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
