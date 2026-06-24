import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';

class VehicleItemWidget extends StatelessWidget {
  final String title;
  final String driverName;
  final String status;
  final String time;
  final String category;

  const VehicleItemWidget({
    super.key,
    required this.title,
    required this.driverName,
    required this.status,
    required this.time,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (category.toLowerCase()) {
      case 'motorcycle':
      case 'bike':
        iconData = Icons.motorcycle;
        iconColor = AppColors.cEF4444;
        break;
      case 'cng':
      case 'rickshaw':
        iconData = Icons.electric_rickshaw;
        iconColor = Colors.orange;
        break;
      case 'car':
      default:
        iconData = Icons.directions_car;
        iconColor = AppColors.c3B82F6;
        break;
    }

    return Row(
      children: [
        Container(
          height: 48.h,
          width: 48.h,
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.cF1F1F1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(iconData, color: iconColor, size: 24.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: 'Urbanist', fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.c000000),
              ),
              SizedBox(height: 2.h),
              Text(
                "Driver: $driverName",
                style: TextStyle(fontFamily: 'Urbanist', fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.c6B6B6B),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                status,
                style: TextStyle(fontFamily: 'Urbanist', fontSize: 11.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2E7D32)),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              time,
              style: TextStyle(fontFamily: 'Urbanist', fontSize: 11.sp, fontWeight: FontWeight.w500, color: AppColors.c6B6B6B),
            ),
          ],
        ),
      ],
    );
  }
}