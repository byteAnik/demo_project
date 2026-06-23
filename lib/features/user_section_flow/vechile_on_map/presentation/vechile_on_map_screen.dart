import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class VechileOnMapScreen extends StatelessWidget {
  const VechileOnMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // আগের পেজের মতো টাইটেল ও সাবটাইটেল ডামি ডাটা লিস্ট
    final List<Map<String, String>> vehicleInfoList = [
      {"title": "Driver", "subtitle": "Anik Biswas"},
      {"title": "Number Plate", "subtitle": "Dhaka Metro-11-2233"},
    ];

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Stack(
          children: [
            // ১. ব্যাকগ্রাউন্ড ম্যাপ ইমেজ (যা পুরো স্ক্রিন জুড়ে থাকবে)
            Positioned.fill(
              child: Image.asset(
                AssetsImages.vechileMapImage,
                fit: BoxFit.cover,
              ),
            ),

            // ২. টপ সার্চ বার এবং ফিল্টার বাটন (ম্যাপের উপর ওভারলে)
            Positioned(
              top: 20.h,
              left: UIHelper.kDefaulutPadding(),
              right: UIHelper.kDefaulutPadding(),
              child: Row(
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
                            color: Colors.black.withOpacity(0.05),
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
                          color: Colors.black.withOpacity(0.05),
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
            ),

            // ৩. বটম ডিটেইলস কার্ড প্যানেল (Draggable বা ফিক্সড বটম শীট স্টাইল)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIHelper.kDefaulutPadding(),
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // কন্টেন্ট অনুযায়ী হাইট নিবে
                  children: [
                    // টপ ড্র্যাগ হ্যান্ডেল বার
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCCCCC),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),

                    // গাড়ির হেডার অংশ (ইমেজ, নাম, ক্যাটাগরি এবং লাইভ ট্যাগ)
                    Row(
                      children: [
                        Image.asset(
                          AssetsImages.carImage, // আপনার কার ইমেজের পাথ দিন
                          width: 45.w,
                          fit: BoxFit.contain,
                        ),
                        UIHelper.horizontalSpace(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Toyota Axio",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              Text(
                                "Car",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF5F6368),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            "Live",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF137333),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(12.h),
                    const Divider(color: Color(0xFFE0E0E0), thickness: 1),

                    // ড্রাইভার এবং নাম্বার প্লেট ইনফো (ListView.builder দিয়ে জেনারেট করা)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vehicleInfoList.length,
                      itemBuilder: (context, index) {
                        final item = vehicleInfoList[index];
                        final bool isDriver = item['title'] == "Driver";

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  Icon(
                                    isDriver
                                        ? Icons.person_outline
                                        : Icons.badge_outlined,
                                    size: 22.sp,
                                    color: const Color(0xFF5F6368),
                                  ),
                                  UIHelper.horizontalSpace(16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title']!,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF5F6368),
                                          ),
                                        ),
                                        Text(
                                          item['subtitle']!,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isDriver)
                                    Container(
                                      width: 36.w,
                                      height: 36.w,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE8F0FE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        size: 16.sp,
                                        color: const Color(0xFF1A73E8),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFE0E0E0),
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),

                    // স্পিড এবং স্ট্যাটাস রো (পাশাপাশি গ্রিড ভিউ লেআউট)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 22.sp,
                            color: const Color(0xFF5F6368),
                          ),
                          UIHelper.horizontalSpace(16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Speed",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5F6368),
                                  ),
                                ),
                                Text(
                                  "45 km/h",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5F6368),
                                  ),
                                ),
                                Text(
                                  "Online",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF137333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
