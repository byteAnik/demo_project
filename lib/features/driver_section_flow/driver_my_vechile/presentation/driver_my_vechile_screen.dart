import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class DriverMyVechileScreen extends StatelessWidget {
  const DriverMyVechileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ১. ভেহিকেল ডিটেইলস এর জন্য ডামি ডাটা লিস্ট
    final List<Map<String, dynamic>> vehicleDetails = [
      {
        "icon": Icons.directions_car_outlined,
        "title": "Vehicle Type",
        "value": "Car",
        "hasDot": false,
      },
      {
        "icon": Icons.pin_outlined,
        "title": "Number Plate",
        "value": "Dhaka Metro-11-2233",
        "hasDot": false,
      },
      {
        "icon": Icons.calendar_today_outlined,
        "title": "Registered On",
        "value": "20 May 2024",
        "hasDot": false,
      },
      {
        "icon": Icons.access_time_outlined,
        "title": "Tracking Status",
        "value": "ON",
        "hasDot": true, // ট্র্যাকিং অন এর সবুজ ডটের জন্য
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(20.h),

                // কাস্টম হেডার / অ্যাপবার রো (Back, Title, More)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20.sp,
                        color: const Color(0xFF1A1A1A),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Text(
                      "My Vehicle",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    PopupMenuButton<String>(
                      color: AppColors.cFFFFFF,
                      elevation: 4,
                      offset: Offset(0, 32.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      onSelected: (value) {
                        if (value == "add_vehicle") {
                          // Add Vehicle action
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: "add_vehicle",
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: 18.sp,
                                color: const Color(0xFF27AE60),
                              ),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                "Add Vechile",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.more_horiz,
                        size: 22.sp,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(30.h),

                // টপ ভেহিকেল প্রোফাইল সেকশন (ইমেজ, নাম এবং অ্যাক্টিভ ট্যাগ)
                Row(
                  children: [
                    Container(
                      width: 90.w,
                      height: 90.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEDF2F7),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(12.w),
                      child: Image.asset(
                        AssetsImages.carImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    UIHelper.horizontalSpace(20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Toyota Axio",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F4EA),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF137333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20.h),

                // ২. ListView.builder ব্যবহার করে ডিটেইলস লিস্ট তৈরি
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vehicleDetails.length,
                  itemBuilder: (context, index) {
                    final item = vehicleDetails[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F3F4),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'],
                            size: 20.sp,
                            color: const Color(0xFF5F6368),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Text(
                            item['title'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF5F6368),
                            ),
                          ),
                          const Spacer(),
                          if (item['hasDot'] == true) ...[
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF27AE60),
                                shape: BoxShape.circle,
                              ),
                            ),
                            UIHelper.horizontalSpace(6.w),
                          ],
                          Text(
                            item['value'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                UIHelper.verticalSpace(40.h),

                // নিচের বটম অ্যাকশন বাটন রো (Edit & Delete)
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFDCDCDC),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Edit Vehicle",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFFFEAEA),
                              width: 1,
                            ),
                            backgroundColor: const Color(0xFFFFF5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Delete Vehicle",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFEA4335),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
