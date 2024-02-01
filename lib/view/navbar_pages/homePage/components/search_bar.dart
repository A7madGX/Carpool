import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocus = FocusNode();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 0.7.sw,
          height: 50.h,
          decoration: BoxDecoration(
            color: LightTheme.lightGreyTheme,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: TextField(
            focusNode: searchFocus,
            style: TextStyle(color: LightTheme.darkgreyTheme, fontSize: 15.sp),
            onEditingComplete: () {
              searchFocus.unfocus();
            },
            decoration: InputDecoration(
              hintStyle: TextStyle(color: LightTheme.secondaryfontTheme),
              hintText: "Search..",
              prefixIcon: SvgPicture.asset(
                "assets/icons/search.svg",
                fit: BoxFit.scaleDown,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<StateController>().toggleThemeMode();
            // ignore: avoid_print
            // print('toggle yaad');
          },
          child: Container(
            width: 0.15.sw,
            height: 50.h,
            decoration: BoxDecoration(
                color: LightTheme.lightGreyTheme, borderRadius: BorderRadius.circular(20.r)),
            child: Icon(
              Icons.settings_outlined,
              color: LightTheme.darkgreyTheme,
            ),
          ),
        )
      ],
    );
  }
}
