import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatefulWidget {
  final String attribute;
  final String value;
  const InfoTile({
    super.key,
    required this.attribute,
    required this.value,
  });

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: LightTheme.backgroundTheme,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.attribute,
              style: TextStyle(
                color: LightTheme.secondaryfontTheme,
                fontStyle: FontStyle.italic,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 180.w,
            child: Text(
              widget.value,
              style: TextStyle(
                color: LightTheme.mainTheme,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
