import 'package:car_pool/view/navbar_pages/driverHomePage/components/add_trip_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../classes/themes/light_theme.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        backgroundColor: LightTheme.mainTheme.withOpacity(0.4),
      ),
      onPressed: () {
        // Navigator.pushNamed(context, '/addtripscreen');
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: LightTheme.thirdbackgroundTheme,
          builder: (context) => const AddTripBottom(),
        );
      },
      icon: Icon(
        Icons.add_circle,
        color: LightTheme.backgroundTheme,
        size: 30.sp,
      ),
      label: Text(
        'Add Trip  ',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: LightTheme.backgroundTheme,
        ),
      ),
    );
  }
}
