import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
import 'package:latlong2/latlong.dart';

class VechileOnMapScreen extends StatelessWidget {
  const VechileOnMapScreen({super.key, required this.vehicle});

  final Map<String, dynamic> vehicle;

  String get _name => vehicle['name']?.toString() ?? 'Unknown Vehicle';
  String get _type => vehicle['type']?.toString() ?? 'Car';
  String get _driver => vehicle['driver']?.toString() ?? 'Unknown Driver';
  String get _numberPlate => vehicle['numberPlate']?.toString() ?? 'N/A';
  String get _speed => vehicle['time']?.toString() ?? '0 km/h';
  String get _status => vehicle['status']?.toString() ?? 'Online';
  String get _image => vehicle['image']?.toString() ?? AssetsImages.carImage;

  double get _latitude => (vehicle['latitude'] as num?)?.toDouble() ?? 23.7487;
  double get _longitude => (vehicle['longitude'] as num?)?.toDouble() ?? 90.4030;

  Widget _buildMarker() {
    final isMotorcycle = _type.toLowerCase() == 'motorcycle';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      padding: EdgeInsets.all(7.w),
      child: Icon(
        isMotorcycle ? Icons.motorcycle : Icons.directions_car,
        color: isMotorcycle ? AppColors.cEF4444 : AppColors.c3B82F6,
        size: 24.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng vehiclePosition = LatLng(_latitude, _longitude);
    final List<Map<String, String>> vehicleInfoList = [
      {'title': 'Driver', 'subtitle': _driver},
      {'title': 'Number Plate', 'subtitle': _numberPlate},
    ];

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: vehiclePosition,
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: vehiclePosition,
                        width: 48.w,
                        height: 48.w,
                        child: _buildMarker(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16.h,
              left: UIHelper.kDefaulutPadding(),
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: AppColors.c000000),
                  onPressed: Get.back,
                ),
              ),
            ),
            Positioned(
              top: 16.h,
              left: UIHelper.kDefaulutPadding() + 56.w,
              right: UIHelper.kDefaulutPadding(),
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.cFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: const Color(0xFF495057), size: 20.sp),
                    UIHelper.horizontalSpace(10.w),
                    Expanded(
                      child: Text(
                        _name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: const Color(0xFF495057),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCCCCC),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    UIHelper.verticalSpace(16.h),
                    Row(
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEDF2F7),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(7.w),
                          child: Image.asset(
                            _image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.directions_car,
                              color: Color(0xFF495057),
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                              Text(
                                _type,
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
                            _status,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vehicleInfoList.length,
                      itemBuilder: (context, index) {
                        final item = vehicleInfoList[index];
                        final bool isDriver = item['title'] == 'Driver';

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  Icon(
                                    isDriver ? Icons.person_outline : Icons.badge_outlined,
                                    size: 22.sp,
                                    color: const Color(0xFF5F6368),
                                  ),
                                  UIHelper.horizontalSpace(16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            const Divider(color: Color(0xFFE0E0E0), thickness: 1),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.speed_outlined,
                            size: 22.sp,
                            color: const Color(0xFF5F6368),
                          ),
                          UIHelper.horizontalSpace(16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Speed',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5F6368),
                                  ),
                                ),
                                Text(
                                  _speed,
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
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5F6368),
                                  ),
                                ),
                                Text(
                                  _status,
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
