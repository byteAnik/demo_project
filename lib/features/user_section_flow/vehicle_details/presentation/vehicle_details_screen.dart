import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/vechile_on_map/presentation/vechile_on_map_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vehicleInfoList = [
      {
        "icon": Icons.person_outline,
        "title": "Driver",
        "subtitle": "Anik Biswas",
        "hasCallButton": true, // শুধুমাত্র ড্রাইভার লাইনে কল বাটন দেখানোর জন্য
      },
      {
        "icon": Icons.directions_car_filled_outlined,
        "title": "Vehicle Type",
        "subtitle": "Car",
        "hasCallButton": false,
      },
      {
        "icon": Icons
            .badge_outlined, // অথবা Icons.credit_card_outlined ব্যবহার করতে পারেন
        "title": "Number Plate",
        "subtitle": "Dhaka Metro-11-2233",
        "hasCallButton": false,
      },
      {
        "icon": Icons.access_time,
        "title": "Last Updated",
        "subtitle": "2 mins ago",
        "hasCallButton": false,
      },
      {
        "icon": Icons.speed_outlined,
        "title": "Speed",
        "subtitle": "45 km/h",
        "hasCallButton": false,
      },
      {
        "icon": Icons.gpp_good_outlined, // স্ট্যাটাসের জন্য শিল্ড/লক আইকন
        "title": "Status",
        "subtitle": "Online",
        "hasCallButton": false,
        "isStatus": true, // স্ট্যাটাসের টেক্সট সবুজ করার জন্য
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFFF,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16.sp,
            color: AppColors.c000000,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Vehicle Details",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.c000000,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.c000000),
            onPressed: () {},
          ),
          UIHelper.horizontalSpace(8.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(24.h),

                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDF2F7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        AssetsImages.carImage,
                        width: 70.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),

                  Text(
                    "Toyota Axio",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.c000000,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFE6F4EA,
                      ), // হালকা সবুজ ব্যাকগ্রাউন্ড
                      borderRadius: BorderRadius.circular(20.r), // ওভাল শেপ
                    ),
                    child: Text(
                      "Live",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF137333), // গাড় সবুজ টেক্সট কালার
                      ),
                    ),
                  ),

                  UIHelper.verticalSpace(20.h),
                  ListView.separated(
                    itemCount: vehicleInfoList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        UIHelper.verticalSpace(16.h),
                    itemBuilder: (context, index) {
                      final info = vehicleInfoList[index];
                      return Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Icon(
                                info["icon"],
                                size: 20.sp,
                                color: AppColors.c000000,
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  info["title"],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                                UIHelper.verticalSpace(4.h),
                                Text(
                                  info["subtitle"],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.c000000,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (info["hasCallButton"] == true)
                            GestureDetector(
                              onTap: () {
                                // এখানে কলের লজিক থাকবে
                              },
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F4EA),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.phone,
                                    size: 20.sp,
                                    color: const Color(0xFF137333),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  UIHelper.verticalSpace(20.h),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => VechileOnMapScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.c3B82F6,
                      minimumSize: Size(double.infinity, 56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "View on Map",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
