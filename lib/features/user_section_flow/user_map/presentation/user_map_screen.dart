import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/user_map/data/vehicle_data.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/user_map/presentation/widgets/category_chip_widget.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/user_map/presentation/widgets/vehicle_item_widget.dart';
import 'package:latlong2/latlong.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  String _selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // ফায়ারবেস ডাটা ফিল্টারিং মেথড
  List<Map<String, dynamic>> _filterFirebaseVehicles(List<QueryDocumentSnapshot> docs) {
    List<Map<String, dynamic>> allVehicles = docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      String category = data["vehicleType"] ?? "Car";
      return {
        "id": doc.id,
        "title": data["vehicleName"] ?? "Unknown Vehicle",
        "driverName": data["driverName"] ?? "Unknown Driver",
        "category": category,
        "status": (data["isTracking"] ?? false) ? "Active" : "Offline",
        "time": data["speed"] ?? "0 km/h",
        "latitude": (data["latitude"] as num?)?.toDouble() ?? 23.7487,
        "longitude": (data["longitude"] as num?)?.toDouble() ?? 90.4030,
        "isTracking": data["isTracking"] ?? false,
      };
    }).toList();

    // শুধুমাত্র একটিভ ট্র্যাকিং অন থাকা গাড়ি ফিল্টার
    List<Map<String, dynamic>> list = allVehicles.where((v) => v["isTracking"] == true).toList();

    // ক্যাটাগরি ফিল্টার
    if (_selectedCategory != "All") {
      list = list.where((v) => v["category"].toString().toLowerCase() == _selectedCategory.toLowerCase()).toList();
    }

    // সার্চ কুয়েরি ফিল্টার
    if (_searchQuery.isNotEmpty) {
      list = list.where((v) {
        return v["title"].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
            v["driverName"].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    return list;
  }

  // ম্যাপের জন্য কাস্টম মার্কার ডিজাইন
  Widget _getMarkerIcon(String category) {
    IconData iconData;
    Color iconColor;

    switch (category.toLowerCase()) {
      case 'motorcycle':
      case 'bike':
        iconData = Icons.motorcycle;
        iconColor = AppColors.cEF4444; // Red
        break;
      case 'cng':
      case 'rickshaw':
        iconData = Icons.electric_rickshaw; // Orange
        iconColor = Colors.orange;
        break;
      case 'car':
      default:
        iconData = Icons.directions_car;
        iconColor = AppColors.c3B82F6; // Blue
        break;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.all(6.w),
      child: Icon(iconData, color: iconColor, size: 22.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        bottom: false,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('active_vehicles').snapshots(),
          builder: (context, snapshot) {
            List<Map<String, dynamic>> filtered = [];
            List<Marker> markers = [];

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Firebase Error: ${snapshot.error}',
                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              filtered = _filterFirebaseVehicles(snapshot.data!.docs);
              markers = filtered.map((vehicle) {
                return Marker(
                  point: LatLng(vehicle["latitude"], vehicle["longitude"]),
                  width: 45.w,
                  height: 45.w,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _mapController.move(LatLng(vehicle["latitude"], vehicle["longitude"]), 18.0);
                    },
                    child: _getMarkerIcon(vehicle["category"]),
                  ),
                );
              }).toList();
            }

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu, size: 28.sp, color: AppColors.c000000),
                          Text(
                            "Vehicles",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.c000000,
                            ),
                          ),
                          Icon(Icons.notifications_none, size: 28.sp, color: AppColors.c000000),
                        ],
                      ),
                    ),

                    // Search Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.cF9FAFB,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.cF1F1F1),
                              ),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) => setState(() => _searchQuery = value),
                                style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: AppColors.c000000),
                                decoration: InputDecoration(
                                  hintText: "Search vehicle or driver...",
                                  hintStyle: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: AppColors.c6B6B6B),
                                  prefixIcon: Icon(Icons.search, color: AppColors.c6B6B6B, size: 22.sp),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.cF9FAFB,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.cF1F1F1),
                            ),
                            child: const Center(child: Icon(Icons.filter_alt_outlined, color: AppColors.c000000)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Categories Chips
                    SizedBox(
                      height: 38.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: kCategories.length,
                        itemBuilder: (context, index) {
                          final category = kCategories[index];
                          return GestureDetector(
                            onTap: () => setState(() => _selectedCategory = category),
                            child: CategoryChipWidget(
                              title: category,
                              isSelected: category == _selectedCategory,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Live Interactive Map (OpenStreetMap)
                    Expanded(
                      child: FlutterMap(
                        mapController: _mapController,
                        options: const MapOptions(
                          initialCenter: LatLng(23.7487, 90.4030), // ঢাকা সেন্টারড
                          initialZoom: 14.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                          ),
                          MarkerLayer(markers: markers),
                        ],
                      ),
                    ),
                    SizedBox(height: filtered.isEmpty ? 140.h : (filtered.length * 75.h + 80.h).clamp(100.0, 240.0).h),
                  ],
                ),

                // Bottom Panel Sheet
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 280.h),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 12.h),
                          Container(
                            height: 4.h,
                            width: 40.w,
                            decoration: BoxDecoration(color: AppColors.cE6E6E6, borderRadius: BorderRadius.circular(2.r)),
                          ),
                          SizedBox(height: 16.h),

                          // Header Text
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Nearby Vehicles",
                                  style: TextStyle(fontFamily: 'Urbanist', fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.c000000),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(color: AppColors.c3B82F6.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                                  child: Text(
                                    "${filtered.length}",
                                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.c3B82F6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Vehicle List / Empty Screen
                          if (filtered.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Column(
                                children: [
                                  Icon(Icons.search_off, size: 36.sp, color: AppColors.c9E9E9E),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "No vehicles found",
                                    style: TextStyle(fontFamily: 'Urbanist', fontSize: 14.sp, color: AppColors.c6B6B6B),
                                  ),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
                              itemCount: filtered.length,
                              separatorBuilder: (context, index) => Column(
                                children: [
                                  SizedBox(height: 12.h),
                                  Divider(color: AppColors.cF1F1F1, height: 1),
                                  SizedBox(height: 12.h),
                                ],
                              ),
                              itemBuilder: (context, index) {
                                final vehicle = filtered[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    _mapController.move(LatLng(vehicle["latitude"], vehicle["longitude"]), 18.0);
                                  },
                                  child: VehicleItemWidget(
                                    title: vehicle["title"],
                                    driverName: vehicle["driverName"],
                                    status: vehicle["status"],
                                    time: vehicle["time"],
                                    category: vehicle["category"],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}