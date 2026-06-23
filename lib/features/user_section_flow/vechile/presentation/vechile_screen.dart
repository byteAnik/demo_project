import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/vehicle_details/presentation/vehicle_details_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class VechileScreen extends StatelessWidget {
  const VechileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ইমেজের ডাটার সাথে মিল রেখে ডামি ডাটা লিস্ট আপডেট করা হয়েছে
    final List<Map<String, String>> vehicleList = [
      {
        "name": "Toyota Axio",
        "type": "Car",
        "driver": "Anik Biswas",
        "time": "2 mins ago",
        "image": AssetsImages.carImage,
      },
      {
        "name": "Yamaha FZ-S",
        "type": "Motorcycle",
        "driver": "Rakib Hasan",
        "time": "1 min ago",
        "image": AssetsImages.bike,
      },
      {
        "name": "CNG Auto",
        "type": "CNG",
        "driver": "Salim Uddin",
        "time": "3 mins ago",
        "image": AssetsImages.vechileMapImage,
      },
      {
        "name": "Rickshaw",
        "type": "Rickshaw",
        "driver": "Karim Ali",
        "time": "5 mins ago",
        "image": AssetsImages.trackingImage,
      },
      {
        "name": "Delivery Van",
        "type": "Delivery",
        "driver": "Shohan",
        "time": "1 min ago",
        "image": AssetsImages.userMapScreen,
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

              // ১. স্ক্রিন হেডার টাইটেল
              Center(
                child: Text(
                  'Vehicles',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.c000000,
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),

              // ২. সার্চ বার এবং ফিল্টার বাটন রো
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE9ECEF),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search vehicle or driver...",
                          hintStyle: TextStyle(
                            color: Color(0xFF868E96),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF495057),
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFFE9ECEF),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.tune,
                        color: Color(0xFF495057),
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(20.h),

              // ৩. নতুন ইমেজ অনুযায়ী কাস্টমাইজড ভেহিকেল লিস্ট ভিউ
              Expanded(
                child: ListView.builder(
                  itemCount: vehicleList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final vehicle = vehicleList[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VehicleDetailsScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cFFFFFF,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFE9ECEF),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // বামপাশের সার্কুলার ইমেজ ব্যাকগ্রাউন্ড
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: const BoxDecoration(
                                color: Color(
                                  0xFFEDF2F7,
                                ), // হালকা নীলচে ব্যাকগ্রাউন্ড
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(6.w),
                              child: Image.asset(
                                vehicle['image']!,
                                fit: BoxFit.contain,
                                // ইমেজ লোড না হলে ব্যাকআপ হিসেবে একটি আইকন দেখাবে
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.directions_car,
                                      color: Color(0xFF495057),
                                    ),
                              ),
                            ),
                            UIHelper.horizontalSpace(12.w),

                            // মাঝখানের টেক্সট ব্লক (Name, Type • Driver)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle['name']!,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  UIHelper.verticalSpace(4.h),
                                  Text(
                                    "${vehicle['type']}  •  ${vehicle['driver']}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF7F8C8D),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ডানপাশের সেকশন (Live ট্যাগ এবং টাইম)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Live ব্যাজ
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFE6F4EA,
                                    ), // হালকা সবুজ
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    "Live",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF137333),
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(6.h),
                                // টাইম টেক্সট
                                Text(
                                  vehicle['time']!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF7F8C8D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
