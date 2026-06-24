import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/vechile_on_map/presentation/vechile_on_map_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key, required this.vehicle});

  final Map<String, dynamic> vehicle;

  String get _name => vehicle['name']?.toString() ?? 'Unknown Vehicle';
  String get _type => vehicle['type']?.toString() ?? 'Car';
  String get _driver => vehicle['driver']?.toString() ?? 'Unknown Driver';
  String get _numberPlate => vehicle['numberPlate']?.toString() ?? 'N/A';
  String get _lastUpdated => vehicle['lastUpdated']?.toString() ?? 'Live now';
  String get _speed => vehicle['time']?.toString() ?? '0 km/h';
  String get _status => vehicle['status']?.toString() ?? 'Online';
  String get _image => vehicle['image']?.toString() ?? AssetsImages.carImage;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> vehicleInfoList = [
      {
        'icon': Icons.person_outline,
        'title': 'Driver',
        'subtitle': _driver,
        'hasCallButton': true,
      },
      {
        'icon': Icons.directions_car_filled_outlined,
        'title': 'Vehicle Type',
        'subtitle': _type,
        'hasCallButton': false,
      },
      {
        'icon': Icons.badge_outlined,
        'title': 'Number Plate',
        'subtitle': _numberPlate,
        'hasCallButton': false,
      },
      {
        'icon': Icons.access_time,
        'title': 'Last Updated',
        'subtitle': _lastUpdated,
        'hasCallButton': false,
      },
      {
        'icon': Icons.speed_outlined,
        'title': 'Speed',
        'subtitle': _speed,
        'hasCallButton': false,
      },
      {
        'icon': Icons.gpp_good_outlined,
        'title': 'Status',
        'subtitle': _status,
        'hasCallButton': false,
        'isStatus': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: AppBar(
        backgroundColor: AppColors.cFFFFFF,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 16.sp,
            color: AppColors.c000000,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          'Vehicle Details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.c000000,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.c000000),
            onPressed: () {},
          ),
          UIHelper.horizontalSpace(8.w),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UIHelper.verticalSpace(24.h),
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDF2F7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        _image,
                        width: 70.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.directions_car,
                          size: 52.sp,
                          color: const Color(0xFF495057),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  Text(
                    _name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.c000000,
                    ),
                  ),
                  UIHelper.verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      _status,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF137333),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20.h),
                  ListView.separated(
                    itemCount: vehicleInfoList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => UIHelper.verticalSpace(16.h),
                    itemBuilder: (context, index) {
                      final info = vehicleInfoList[index];
                      final bool isStatus = info['isStatus'] == true;

                      return Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Icon(
                                info['icon'] as IconData,
                                size: 20.sp,
                                color: AppColors.c000000,
                              ),
                            ),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  info['title'].toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF475569),
                                  ),
                                ),
                                UIHelper.verticalSpace(4.h),
                                Text(
                                  info['subtitle'].toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isStatus ? const Color(0xFF137333) : AppColors.c000000,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (info['hasCallButton'] == true)
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F4EA),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.phone,
                                    size: 20.sp,
                                    color: const Color(0xFF137333),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  UIHelper.verticalSpace(20.h),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => VechileOnMapScreen(vehicle: vehicle));
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
                      'View on Map',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
