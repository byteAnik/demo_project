import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/auth/controller/driver_home_controller.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/live_tracking/presentation/live_tracking_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
// আপনার প্রজেক্টের সঠিক পাথ অনুযায়ী লাইভ ট্র্যাকিং স্ক্রিনটি ইমপোর্ট করুন

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.put(DriverHomeController());
    final String? currentUid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: currentUid == null
            ? const Center(child: Text('Driver not logged in!'))
            : StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('active_vehicles')
                    .doc(currentUid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                      child: Text(
                        'No vehicle registered under this account.\nPlease add vehicle details.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  }

                  final vehicleData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final String driverName =
                      vehicleData['driverName']?.toString() ?? 'No Name';
                  final String vehicleName =
                      vehicleData['vehicleName']?.toString() ?? 'No Vehicle';
                  final String vehicleType =
                      vehicleData['vehicleType']?.toString() ?? 'car';
                  final bool isTracking = vehicleData['isTracking'] == true;
                  final String speed =
                      vehicleData['speed']?.toString() ?? '0 km/h';

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UIHelper.kDefaulutPadding(),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIHelper.verticalSpace(20.h),
                          _profilePanel(
                            driverName: driverName,
                            speed: speed,
                            isTracking: isTracking,
                          ),
                          UIHelper.verticalSpace(24.h),
                          _sectionTitle('My Vehicle'),
                          UIHelper.verticalSpace(12.h),
                          _vehicleCard(
                            vehicleName: vehicleName,
                            vehicleType: vehicleType,
                            isTracking: isTracking,
                          ),
                          UIHelper.verticalSpace(24.h),
                          _sectionTitle('Tracking Status'),
                          UIHelper.verticalSpace(12.h),
                          _trackingStatusCard(isTracking),
                          UIHelper.verticalSpace(16.h),
                          _trackingButtons(controller),
                          UIHelper.verticalSpace(24.h),
                          _sectionTitle('Quick Actions'),
                          UIHelper.verticalSpace(12.h),
                          _quickActions(isTracking), // এখানে ট্র্যাকিং স্ট্যাটাস পাস করা হলো
                          UIHelper.verticalSpace(20.h),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _profilePanel({
    required String driverName,
    required String speed,
    required bool isTracking,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isTracking ? const Color(0xFF27AE60) : const Color(0xFF7F8C8D),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor: const Color(0xFFE2E8F0),
            backgroundImage: AssetImage(AssetsImages.anik),
          ),
          UIHelper.horizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $driverName',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Speed: $speed',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isTracking ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _vehicleCard({
    required String vehicleName,
    required String vehicleType,
    required bool isTracking,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F3F4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            padding: EdgeInsets.all(4.w),
            child: Image.asset(AssetsImages.carImage, fit: BoxFit.contain),
          ),
          UIHelper.horizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Type: ${vehicleType.capitalizeFirst}',
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
              color: isTracking
                  ? const Color(0xFFE6F4EA)
                  : const Color(0xFFFCE8E6),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isTracking ? 'Active' : 'Inactive',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isTracking
                    ? const Color(0xFF137333)
                    : const Color(0xFFC5221F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackingStatusCard(bool isTracking) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F3F4)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.sensors,
            color: isTracking
                ? const Color(0xFF27AE60)
                : const Color(0xFFEA4335),
            size: 22.sp,
          ),
          UIHelper.horizontalSpace(12.w),
          Text(
            isTracking ? 'Tracking is ON' : 'Tracking is OFF',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isTracking
                  ? const Color(0xFF27AE60)
                  : const Color(0xFFEA4335),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackingButtons(DriverHomeController controller) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 46.h,
            child: ElevatedButton(
              onPressed: controller.startTracking,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27AE60),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Start Tracking',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 46.h,
            child: ElevatedButton(
              onPressed: controller.stopTracking,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEA4335),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Stop Tracking',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _quickActions(bool isTracking) {
    return Row(
      children: [
        Expanded(
          child: _quickActionButton(
            icon: Icons.travel_explore_outlined,
            label: 'View on Map',
            onTap: () {
              // 🚀 ট্র্যাকিং অন থাকলে ম্যাপ স্ক্রিনে যাবে, অফ থাকলে স্নাকবার অ্যালার্ট দেবে
              if (isTracking) {
                Get.to(() => const LiveTrackingScreen());
              } else {
                Get.snackbar(
                  'Tracking Inactive',
                  'Please start tracking to view live map simulation.',
                  backgroundColor: const Color(0xFFE67E22),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _quickActionButton(
            icon: Icons.edit_road_outlined,
            label: 'Edit Vehicle',
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _quickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFF1F3F4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF2F6BFF), size: 18.sp),
            UIHelper.horizontalSpace(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2F6BFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}