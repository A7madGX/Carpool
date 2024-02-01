import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class MySlider extends StatelessWidget {
  const MySlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myItems = [
      {
        'title': "Laptop X",
        'discountPercentage': 12.96,
        'image': "assets/images/laptop_cartoon.svg",
      },
      {
        'title': "iPhone X",
        'discountPercentage': 20.56,
        'image': "assets/images/smartphone_cartoon.svg",
      },
      {
        'title': "Perfume",
        'discountPercentage': 48.20,
        'image': "assets/images/perfume.svg",
      },
      {
        'title': "Skincare",
        'discountPercentage': 22.50,
        'image': "assets/images/skincare.svg",
      },
    ];
    return Consumer<StateController>(builder: (context, controller, child) {
      return SizedBox(
        width: 1.sw,
        height: 190.h,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Latest Rides',
                  style: TextStyle(
                      color: LightTheme.fontTheme, fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            5.verticalSpace,
            SizedBox(
              height: 140.h,
              width: 1.sw,
              child: CarouselSlider.builder(
                options:
                    CarouselOptions(viewportFraction: 1, autoPlay: true, enlargeCenterPage: true),
                itemCount: myItems.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                  padding:
                      const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0, right: 15.0).w,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: LightTheme.thirdbackgroundTheme,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 42.h),
                              child: Text(
                                myItems[itemIndex]['title'],
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: LightTheme.fontTheme,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              ),
                            ),
                            20.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  '${myItems[itemIndex]["discountPercentage"]}%',
                                  style: TextStyle(
                                      color: LightTheme.mainTheme,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                5.horizontalSpace,
                                Text(
                                  'OFF',
                                  style: TextStyle(
                                      color: LightTheme.mainTheme,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                )
                              ],
                            ),
                            Text(
                              '05 - 09 July',
                              style:
                                  TextStyle(color: LightTheme.secondaryfontTheme, fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 130.w,
                        height: double.infinity,
                        child: SvgPicture.asset(
                          myItems[itemIndex]['image'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
