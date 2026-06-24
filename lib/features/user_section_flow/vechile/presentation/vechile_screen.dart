import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/vehicle_details/presentation/vehicle_details_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class VechileScreen extends StatefulWidget {
  const VechileScreen({super.key});

  @override
  State<VechileScreen> createState() => _VechileScreenState();
}

class _VechileScreenState extends State<VechileScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getVehicleImage(String type) {
    switch (type.toLowerCase()) {
      case 'car':
        return AssetsImages.carImage;
      case 'motorcycle':
      case 'bike':
        return AssetsImages.bike;
      case 'cng':
        return AssetsImages.vechileMapImage;
      case 'rickshaw':
        return AssetsImages.trackingImage;
      default:
        return AssetsImages.userMapScreen;
    }
  }

  String _formatSpeed(dynamic speed) {
    if (speed == null) return '0 km/h';
    if (speed is num) return '${speed.toStringAsFixed(speed % 1 == 0 ? 0 : 1)} km/h';

    final value = speed.toString();
    return value.toLowerCase().contains('km/h') ? value : '$value km/h';
  }

  String _formatLastUpdated(dynamic value) {
    if (value is Timestamp) {
      final difference = DateTime.now().difference(value.toDate());
      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inHours < 1) return '${difference.inMinutes} mins ago';
      if (difference.inDays < 1) return '${difference.inHours} hours ago';
      return '${difference.inDays} days ago';
    }

    if (value is DateTime) {
      final difference = DateTime.now().difference(value);
      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inHours < 1) return '${difference.inMinutes} mins ago';
      if (difference.inDays < 1) return '${difference.inHours} hours ago';
      return '${difference.inDays} days ago';
    }

    return value?.toString() ?? 'Live now';
  }

  List<Map<String, dynamic>> _filterVehicles(List<QueryDocumentSnapshot> docs) {
    List<Map<String, dynamic>> list = docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final type = data['vehicleType']?.toString() ?? 'Car';
      final isTracking = data['isTracking'] == true;

      return {
        'id': doc.id,
        'name': data['vehicleName']?.toString() ?? 'Unknown Vehicle',
        'type': type,
        'driver': data['driverName']?.toString() ?? 'Unknown Driver',
        'driverPhone': data['driverPhone']?.toString() ?? data['phone']?.toString() ?? '',
        'numberPlate': data['numberPlate']?.toString() ?? data['vehicleNumber']?.toString() ?? data['plateNumber']?.toString() ?? 'N/A',
        'time': _formatSpeed(data['speed']),
        'lastUpdated': _formatLastUpdated(data['updatedAt'] ?? data['lastUpdated']),
        'status': isTracking ? 'Online' : 'Offline',
        'image': _getVehicleImage(type),
        'isTracking': isTracking,
        'latitude': (data['latitude'] as num?)?.toDouble(),
        'longitude': (data['longitude'] as num?)?.toDouble(),
      };
    }).toList();

    list = list.where((v) => v['isTracking'] == true).toList();

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      list = list.where((v) {
        return v['name'].toString().toLowerCase().contains(query) ||
            v['driver'].toString().toLowerCase().contains(query) ||
            v['numberPlate'].toString().toLowerCase().contains(query);
      }).toList();
    }

    return list;
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Center(
                child: Text(
                  'Vehicles',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.c000000,
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),
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
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14.sp,
                          color: AppColors.c000000,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search vehicle or driver...',
                          hintStyle: TextStyle(
                            fontFamily: 'Urbanist',
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('active_vehicles').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: Colors.red),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No active vehicles found.',
                          style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: const Color(0xFF7F8C8D)),
                        ),
                      );
                    }

                    final filteredVehicles = _filterVehicles(snapshot.data!.docs);

                    if (filteredVehicles.isEmpty) {
                      return Center(
                        child: Text(
                          'No vehicles match your search.',
                          style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: const Color(0xFF7F8C8D)),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredVehicles.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final vehicle = filteredVehicles[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VehicleDetailsScreen(vehicle: vehicle));
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
                                Container(
                                  width: 48.w,
                                  height: 48.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEDF2F7),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(6.w),
                                  child: Image.asset(
                                    vehicle['image'].toString(),
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
                                        vehicle['name'].toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      UIHelper.verticalSpace(4.h),
                                      Text(
                                        '${vehicle['type']}  •  ${vehicle['driver']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF7F8C8D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                UIHelper.horizontalSpace(8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE6F4EA),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Text(
                                        'Live',
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF137333),
                                        ),
                                      ),
                                    ),
                                    UIHelper.verticalSpace(6.h),
                                    Text(
                                      vehicle['time'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF27AE60),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
