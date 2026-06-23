// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:svg_flutter/svg.dart';

// class NavigationCreatorBar extends StatefulWidget {
//   final int? pageNum;
//   const NavigationCreatorBar({super.key, this.pageNum});

//   @override
//   State<NavigationCreatorBar> createState() => _NavigationCreatorBarState();
// }

// class _NavigationCreatorBarState extends State<NavigationCreatorBar> {
//   late int _currentIndex;

//   final List<Widget> _screens = [
//     HomeScreenCreator(),
//     CreatorChatScreen(),
//     CreatorPostScreen(),
//     CreatorVaultPageScreen(),
//     CreatorSettingPageScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.pageNum ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         showMaterialDialog(context);
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.c1B1B1B,
//         extendBody: true,
//         body: _screens[_currentIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: AppColors.c1B1B1B,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                 spreadRadius: 5,
//                 blurRadius: 10,
//                 offset: Offset(0, 0),
//               ),
//             ],
//           ),
//           child: BottomNavigationBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               log("----------------index--$index");
//               setState(() => _currentIndex = index);
//             },
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: AppColors.cFFFFFF,
//             unselectedItemColor: AppColors.c8B8A8C,
//             selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
//             unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
//             items: [
//               _buildNavItem(
//                 iconPath: AssetsIcons.homeIcon1,
//                 label: "News Feed",
//                 index: 0,
//                 isSvg: false,
//               ),
//               _buildNavItem(
//                 iconPath: AssetsIcons.messageIcon,
//                 label: "Whyspers",
//                 index: 1,
//                 isSvg: true,
//               ),
//               _buildNavItem(
//                 iconPath: AssetsIcons.addIcon,
//                 label: "Add",
//                 index: 2,
//                 isSvg: false,
//               ),
//               _buildNavItem(
//                 iconPath: AssetsIcons.vaultIcon,
//                 label: "Vault",
//                 index: 3,
//                 isSvg: false,
//               ),
//               _buildNavItem(
//                 iconPath: AssetsIcons.homeScreenSettingIcon,
//                 label: "Settings",
//                 index: 4,
//                 isSvg: false,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Cleaned-up helper for BottomNavigationBarItem
//   BottomNavigationBarItem _buildNavItem({
//     required String iconPath,
//     required String label,
//     required int index,
//     required bool isSvg,
//   }) {
//     final color = _currentIndex == index ? AppColors.cFFFFFF : AppColors.c8B8A8C;

//     Widget iconWidget;
//     if (isSvg) {
//       iconWidget = SvgPicture.asset(
//         iconPath,
//         height: 24.h,
//         width: 24.w,
//         // ignore: deprecated_member_use
//         color: color,
//       );
//     } else {
//       iconWidget = Image.asset(
//         iconPath,
//         height: 24.h,
//         width: 24.w,
//         color: color,
//       );
//     }

//     return BottomNavigationBarItem(
//       icon: iconWidget,
//       label: label,
//     );
//   }
// }
