import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_icons.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/driver_home/presentation/driver_home_screen.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/driver_my_vechile/presentation/driver_my_vechile_screen.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/driver_profile/presentation/driver_profile_screen.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/tracking_history/presentation/tracking_history_screen.dart';
import 'package:gps_tracking_system_app/helpers/helper_methods.dart';
import 'package:svg_flutter/svg.dart';

class DriverNavigationBarScreen extends StatefulWidget {
  final int? pageNum;
  const DriverNavigationBarScreen({super.key, this.pageNum});

  @override
  State<DriverNavigationBarScreen> createState() => _DriverNavigationBarScreenState();
}

class _DriverNavigationBarScreenState extends State<DriverNavigationBarScreen> {
  late int _currentIndex;

  final List<Widget> _screens = [
    DriverHomeScreen(),
    DriverMyVechileScreen(),
    TrackingHistoryScreen(),
    DriverProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showMaterialDialog(context);
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.cFFFFFF,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.06 * 255).toInt()),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: _currentIndex,
            onTap: (index) {
              log("----------------index--$index");
              setState(() => _currentIndex = index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF2F6BFF),
            unselectedItemColor: const Color(0xFF5F6368),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            items: [
              _buildNavItem(
                iconPath: AssetsIcons.homeIcon,
                label: "Dashboard",
                index: 0,
                isSvg: false,
              ),
              _buildNavItem(
                iconPath: AssetsIcons.carIcon,
                label: "Vehicles",
                index: 1,
                isSvg: false,
              ),
              _buildNavItem(
                iconPath: AssetsIcons.historyIcon,
                label: "History",
                index: 2,
                isSvg: false,
              ),
              _buildNavItem(
                iconPath: AssetsIcons.personIcon,
                label: "Profile",
                index: 3,
                isSvg: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Cleaned-up helper for BottomNavigationBarItem
  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String label,
    required int index,
    required bool isSvg,
  }) {
    final color = _currentIndex == index
        ? const Color(0xFF2F6BFF)
        : const Color(0xFF5F6368);

    Widget iconWidget;
    if (isSvg) {
      iconWidget = SvgPicture.asset(
        iconPath,
        height: 24.h,
        width: 24.w,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      iconWidget = Image.asset(
        iconPath,
        height: 24.h,
        width: 24.w,
        color: color,
      );
    }

    return BottomNavigationBarItem(icon: iconWidget, label: label);
  }
}
