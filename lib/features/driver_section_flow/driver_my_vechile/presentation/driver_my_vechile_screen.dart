import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/driver_add_vechile/presentation/driver_add_vechile_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class DriverMyVechileScreen extends StatelessWidget {
  const DriverMyVechileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                  // ফায়ারবেস থেকে লাইভ ডাটা ম্যাপে কনভার্ট করা
                  final vehicleData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  final String vehicleName =
                      vehicleData['vehicleName']?.toString() ?? 'No Vehicle';
                  final String vehicleType =
                      vehicleData['vehicleType']?.toString() ?? 'Car';
                  final bool isTracking = vehicleData['isTracking'] == true;

                  // যদি নাম্বার প্লেট বা ডেট আপনার ফায়ারবেস মডেলে অলরেডি থাকে, তবে সেই কি (Key) ব্যবহার করবেন
                  final String numberPlate =
                      vehicleData['numberPlate']?.toString() ??
                      'Dhaka Metro-11-2233';
                  final String registeredOn =
                      vehicleData['registeredOn']?.toString() ?? '20 May 2024';

                  // ২. ফায়ারবেসের লাইভ ডাটা দিয়ে ডায়নামিক লিস্ট তৈরি
                  final List<Map<String, dynamic>> vehicleDetails = [
                    {
                      "icon": Icons.directions_car_outlined,
                      "title": "Vehicle Type",
                      "value": vehicleType.capitalizeFirst ?? 'Car',
                      "hasDot": false,
                    },
                    {
                      "icon": Icons.pin_outlined,
                      "title": "Number Plate",
                      "value": numberPlate,
                      "hasDot": false,
                    },
                    {
                      "icon": Icons.calendar_today_outlined,
                      "title": "Registered On",
                      "value": registeredOn,
                      "hasDot": false,
                    },
                    {
                      "icon": Icons.access_time_outlined,
                      "title": "Tracking Status",
                      "value": isTracking ? "ON" : "OFF",
                      "hasDot":
                          isTracking, // ট্র্যাকিং অন থাকলে ট্রু, অফ থাকলে ফলস
                    },
                  ];

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
                          _headerRow(context),
                          UIHelper.verticalSpace(30.h),
                          _vehicleProfileHeader(
                            vehicleName: vehicleName,
                            isTracking: isTracking,
                          ),
                          UIHelper.verticalSpace(20.h),
                          _vehicleDetailsList(vehicleDetails),
                          UIHelper.verticalSpace(40.h),
                          _actionButtons(),
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

  // ১. কাস্টম হেডার / অ্যাপবার রো উইজেট
  Widget _headerRow(BuildContext context) {
    return Row(
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
              Get.to(() => DriverAddVechileScreen());
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
                    "Add Vehicle",
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
    );
  }

  // ২. টপ ভেহিকেল প্রোফাইল সেকশন উইজেট
  Widget _vehicleProfileHeader({
    required String vehicleName,
    required bool isTracking,
  }) {
    return Row(
      children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: const BoxDecoration(
            color: Color(0xFFEDF2F7),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(12.w),
          child: Image.asset(AssetsImages.carImage, fit: BoxFit.cover),
        ),
        UIHelper.horizontalSpace(20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleName,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isTracking
                    ? const Color(0xFFE6F4EA)
                    : const Color(0xFFFCE8E6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                isTracking ? "Active" : "Inactive",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isTracking
                      ? const Color(0xFF137333)
                      : const Color(0xFFC5221F),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ৩. রিয়েল-টাইম ডাটা লিস্ট বিল্ডার উইজেট
  Widget _vehicleDetailsList(List<Map<String, dynamic>> vehicleDetails) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vehicleDetails.length,
      itemBuilder: (context, index) {
        final item = vehicleDetails[index];
        final bool hasDot = item['hasDot'] == true;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFF1F3F4), width: 1),
            ),
          ),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                size: 20.sp,
                color: const Color(0xFF5F6368),
              ),
              UIHelper.horizontalSpace(12.w),
              Text(
                item['title'].toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5F6368),
                ),
              ),
              const Spacer(),
              if (hasDot) ...[
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
                item['value'].toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: hasDot
                      ? const Color(0xFF27AE60)
                      : const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ৪. বটম অ্যাকশন বাটন রো উইজেট
  Widget _actionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFDCDCDC), width: 1),
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
                side: const BorderSide(color: Color(0xFFFFEAEA), width: 1),
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
    );
  }
}
