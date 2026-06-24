import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class TrackingHistoryScreen extends StatelessWidget {
  const TrackingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ১. ট্র্যাকিং হিস্ট্রির জন্য ডামি ডাটা লিস্ট
    final List<Map<String, dynamic>> historyData = [
      {
        "time": "09:41 AM",
        "location": "Moghbazar, Dhaka",
        "speed": "45 km/h",
        "isTop": true, // প্রথম আইটেমটির ডট ব্লু কালার করার জন্য
      },
      {
        "time": "09:31 AM",
        "location": "Farmgate, Dhaka",
        "speed": "40 km/h",
        "isTop": false,
      },
      {
        "time": "09:21 AM",
        "location": "Shahbag, Dhaka",
        "speed": "38 km/h",
        "isTop": false,
      },
      {
        "time": "09:11 AM",
        "location": "Tejgaon, Dhaka",
        "speed": "35 km/h",
        "isTop": false,
      },
      {
        "time": "09:01 AM",
        "location": "Malibagh, Dhaka",
        "speed": "30 km/h",
        "isTop": false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),

              // ২. কাস্টম অ্যাপবার রো (Back Button & Title)
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF1A1A1A)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Spacer(),
                  Text(
                    "Tracking History",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(width: 20.w), // ব্যালেন্স ঠিক রাখার জন্য
                ],
              ),
              UIHelper.verticalSpace(24.h),

              // ৩. কাস্টম ডেট ড্রপডাউন মেনু
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: const Color(0xFFE9ECEF)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, color: const Color(0xFF5F6368), size: 18.sp),
                    UIHelper.horizontalSpace(12.w),
                    Text(
                      "20 May 2024",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1A1A1A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_down, color: const Color(0xFF7F8C8D), size: 22.sp),
                  ],
                ),
              ),
              UIHelper.verticalSpace(24.h),

              // ৪. ListView.builder দিয়ে টাইমলাইন ট্র্যাকিং হিস্ট্রি লিস্ট
              Expanded(
                child: ListView.builder(
                  itemCount: historyData.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = historyData[index];
                    final isLast = index == historyData.length - 1;

                    return IntrinsicHeight(
                      child: Row(
                        children: [
                          // টাইমলাইন বাম পাশের লাইন ও ডট ডিজাইন সেকশন
                          Column(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  color: item["isTop"] ? const Color(0xFF2F6BFF) : const Color(0xFF27AE60),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 1.5.w,
                                    color: const Color(0xFFE9ECEF),
                                  ),
                                ),
                            ],
                          ),
                          UIHelper.horizontalSpace(16.w),

                          // ডান পাশের মেইন ডাটা কার্ড/রো
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item["time"],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF1A1A1A),
                                      ),
                                    ),
                                    Text(
                                      "Speed: ${item["speed"]}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF7F8C8D),
                                      ),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(4.h),
                                Text(
                                  item["location"],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF5F6368),
                                  ),
                                ),
                                // প্রতিটি লাইনের নিচে গ্যাপ এবং হালকা সেপারেটর বর্ডার
                                UIHelper.verticalSpace(16.h),
                                if (!isLast)
                                  const Divider(
                                    color: Color(0xFFF8F9FA),
                                    thickness: 1,
                                  ),
                                UIHelper.verticalSpace(8.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}