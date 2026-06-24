import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/auth/login/presentation/login_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
import 'package:gps_tracking_system_app/navigation_bar.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60.h),
                      // Replace this with your actual image asset
                      Image.asset(
                        AssetsImages.trackingImage,
                        height: 200.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        "Live Multi-Vehicle\nGPS Tracking System",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c000000,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Track all vehicles in real-time\non the map",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c6B6B6B,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => NavigationBarScreen());
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
                  "Continue as User",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cFFFFFF,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              OutlinedButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  side: const BorderSide(color: AppColors.cE6E6E6, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Continue as Driver",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c000000,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
