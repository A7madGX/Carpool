import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StateButton extends StatefulWidget {
  final OrderStatus state;
  const StateButton({super.key, required this.state});

  @override
  State<StateButton> createState() => _StateButtonState();
}

class _StateButtonState extends State<StateButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, _) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: (widget.state == ctrl.buttonPressed)
                ? getStatusColor(widget.state)
                : LightTheme.backgroundTheme,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: LightTheme.greyTheme,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          onPressed: () {
            if (widget.state == ctrl.buttonPressed) {
              ctrl.onStateButton(OrderStatus.none);
            } else {
              ctrl.onStateButton(widget.state);
            }
          },
          child: Text(
            statusToString(widget.state),
            style: TextStyle(color: LightTheme.fontTheme),
          ));
    });
  }
}
