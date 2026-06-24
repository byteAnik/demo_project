import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ১. ট্র্যাকিং স্ট্যাটাস ড্যাশবোর্ডের জন্য ডামি ডাটা লিস্ট
    final List<Map<String, dynamic>> trackingDashboardData = [
      {
        "label": "Speed",
        "value": "45 km/h",
        "isStatus": false,
      },
      {
        "label": "Status",
        "value": "Tracking",
        "isStatus": true,
      },
      {
        "label": "Accuracy",
        "value": "10 m",
        "isStatus": false,
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

              // ১. টপ ভেহিকেল স্ট্যাটাস প্যানেল (নাম, নাম্বার প্লেট এবং অনলাইন ব্যাজ)
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    padding: EdgeInsets.all(4.w),
                    child: Image.asset(
                      AssetsImages.carImage, 
                      fit: BoxFit.contain,
                      
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Toyota Axio",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        UIHelper.verticalSpace(2.h),
                        Text(
                          "Dhaka Metro-11-2233",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7F8C8D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA), 
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF137333),
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),

              // ২. গুগল ম্যাপ কন্টেইনার (লাইভ ট্র্যাকিং পাথ ও মার্কার এরিয়া)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA), 
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFE9ECEF)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Stack(
                      children: [
                        Image.asset(
                          AssetsImages.vechileMapImage, 
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          
                        ),
                        
                        // ম্যাপের ওপরের কাস্টম কার পিন বা লোকেশন ইন্ডিকেটর
                        Positioned(
                          bottom: 80.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 70.w,
                                  height: 70.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F6BFF).withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 44.w,
                                  height: 44.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(8.w),
                                  child: Image.asset(
                                    AssetsImages.carImage,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),

              // ৩. বটম ট্র্যাকিং ডাটা ড্যাশবোর্ড (ডামি ডাটা লিস্ট ও জেনারেটর লুপ দিয়ে তৈরি)
              Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFF1F3F4)),
                ),
                child: Row(
                  children: List.generate(
                    trackingDashboardData.length * 2 - 1, 
                    (index) {
                      // বিজোড় ইনডেক্সের জন্য মাঝখানে ডিভাইডার বসানো হচ্ছে
                      if (index.isOdd) {
                        return _buildDivider();
                      }

                      // জোড় ইনডেক্সের জন্য লিস্ট থেকে ডাটা নিয়ে আইটেম তৈরি করা হচ্ছে
                      final dataIndex = index ~/ 2;
                      final item = trackingDashboardData[dataIndex];

                      return _buildStatusItem(
                        item["label"],
                        item["value"],
                        isStatus: item["isStatus"],
                      );
                    },
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),

              // ৪. Stop Tracking অ্যাকশন বাটন
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // ট্র্যাকিং বন্ধ করার অ্যাকশন
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA4335), 
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Stop Tracking",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
            ],
          ),
        ),
      ),
    );
  }

  // বটম ড্যাশবোর্ডের সিঙ্গেল আইটেম ডিজাইন
  Widget _buildStatusItem(String label, String value, {required bool isStatus}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF7F8C8D),
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: isStatus ? const Color(0xFF27AE60) : const Color(0xFF1A1A1A), 
            ),
          ),
        ],
      ),
    );
  }

  // আইটেমগুলোর মাঝখানের ভার্টিকাল ডিভাইডার লাইন
  Widget _buildDivider() {
    return Container(
      height: 30.h,
      width: 1,
      color: const Color(0xFFE9ECEF),
    );
  }
}