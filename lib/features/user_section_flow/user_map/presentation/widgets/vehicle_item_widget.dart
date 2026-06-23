import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';

class VehicleItemWidget extends StatelessWidget {
  final String title;
  final String driverName;
  final String status;
  final String time;
  final bool isCar;

  const VehicleItemWidget({
    super.key,
    required this.title,
    required this.driverName,
    required this.status,
    required this.time,
    required this.isCar,
  });

  @override
  Widget build(BuildContext context) {
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
            child: isCar
                ? Image.asset(
                    'assets/images/car_icon.png',
                    height: 24.h,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.directions_car,
                      color: AppColors.c3B82F6,
                      size: 24.sp,
                    ),
                  )
                : Image.asset(
                    'assets/images/bike_icon.png',
                    height: 24.h,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.motorcycle,
                      color: AppColors.cEF4444,
                      size: 24.sp,
                    ),
                  ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c000000,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Driver: $driverName",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c6B6B6B,
                ),
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
                color: const Color(0xFFE8F5E9), // Light green background
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2E7D32), // Dark green text
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.c6B6B6B,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
