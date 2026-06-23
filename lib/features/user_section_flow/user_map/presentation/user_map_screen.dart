import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/user_section_flow/user_map/data/vehicle_data.dart';

import 'widgets/category_chip_widget.dart';
import 'widgets/vehicle_item_widget.dart';

class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {
  String _selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredVehicles {
    List<Map<String, dynamic>> list = _selectedCategory == "All"
        ? List.from(kAllVehicles)
        : kAllVehicles
              .where((v) => v["category"] == _selectedCategory)
              .toList();

    if (_searchQuery.isNotEmpty) {
      list = list.where((v) {
        return v["title"].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            v["driverName"].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
      }).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredVehicles;

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
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
                      Icon(
                        Icons.notifications_none,
                        size: 28.sp,
                        color: AppColors.c000000,
                      ),
                    ],
                  ),
                ),

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
                            onChanged: (value) =>
                                setState(() => _searchQuery = value),
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14.sp,
                              color: AppColors.c000000,
                            ),
                            decoration: InputDecoration(
                              hintText: "Search vehicle or driver...",
                              hintStyle: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14.sp,
                                color: AppColors.c6B6B6B,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.c6B6B6B,
                                size: 22.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
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
                        child: const Center(
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: AppColors.c000000,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  height: 38.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: kCategories.length,
                    itemBuilder: (context, index) {
                      final category = kCategories[index];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                        child: CategoryChipWidget(
                          title: category,
                          isSelected: category == _selectedCategory,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                Expanded(
                  child: Image.asset(
                    AssetsImages.userMapScreen,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.cF1F1F1,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 50, color: AppColors.c9E9E9E),
                          SizedBox(height: 10.h),
                          Text(
                            "Map Image Not Found",
                            style: TextStyle(color: AppColors.c9E9E9E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.h),
                    // Drag Handle
                    Container(
                      height: 4.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.cE6E6E6,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Text(
                            "Nearby Vehicles",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.c000000,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.c3B82F6.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "${filtered.length}",
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.c3B82F6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Vehicle List (ListView.builder)
                    if (filtered.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 36.sp,
                              color: AppColors.c9E9E9E,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "No vehicles found",
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14.sp,
                                color: AppColors.c6B6B6B,
                              ),
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: 24.h,
                        ),
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
                          return VehicleItemWidget(
                            title: vehicle["title"],
                            driverName: vehicle["driverName"],
                            status: vehicle["status"],
                            time: vehicle["time"],
                            isCar: vehicle["isCar"],
                          );
                        },
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
