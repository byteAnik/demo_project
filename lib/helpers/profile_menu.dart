// // Show the custom menu using showMenu
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jolo1981_app/constants/app_colors.dart';
// import 'package:jolo1981_app/constants/text_font_style.dart';
// import 'package:jolo1981_app/features/seller_item_details/presentation/widgets/profile_section_widget.dart';
// import '../features/bottom_navigation_bar/bottom_nav_bar.dart';
// import '../features/coin_management/presenation/coin_management_screen.dart';
// import '../features/faq/presentation/faq_screen.dart';
// import '../features/leaderboard/presentation/leaderboard_screen.dart';
// import '../features/settings/presentation/edit_profile/edit_profile.dart';
// import '../features/settings/presentation/setting_screen.dart';
//
// void showProfilePopup(BuildContext context) async {
//   final RenderBox overlay =
//       Overlay.of(context).context.findRenderObject() as RenderBox;
//   final RelativeRect position = RelativeRect.fromSize(
//     Rect.fromPoints(
//       Offset(overlay.size.width - 50, 50), // Position at the top-right
//       Offset(overlay.size.width, 150),
//     ),
//     overlay.size,
//   );
//
//   await showMenu(
//     context: context,
//     position: position,
//     items: [
//       PopupMenuItem<String>(
//         value: 'My Profile',
//         child: Row(
//           children: [
//             ProfileAvatorwidget(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'John Doe',
//                   style: TextFontStyle.textStyle14Poppins6000c000000,
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: AppColors.cFF8717),
//                     Text(
//                       '4.6',
//                       textAlign: TextAlign.center,
//                       style: TextFontStyle.textStyle12Poppins400cFFFFFF
//                           .copyWith(color: AppColors.c000000),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => BottomNavBar(selectIndex: 1), preventDuplicates: false);
//         },
//         value: 'My Items',
//         child: _buildMenuItem('My Items'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => BottomNavBar(selectIndex: 2), preventDuplicates: false);
//         },
//         value: 'Buy Items',
//         child: _buildMenuItem('Buy Items'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => BottomNavBar(selectIndex: 3), preventDuplicates: false);
//         },
//         value: 'Activity',
//         child: _buildMenuItem('Activity'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => EditProfileCScreen());
//         },
//         value: 'Profile',
//         child: _buildMenuItem('Profile'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => CoinManagementScreen());
//         },
//         value: 'Coin Managment',
//         child: _buildMenuItem('Coin Managment'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => LeaderboardScreen());
//         },
//         value: 'Leaderboard',
//         child: _buildMenuItem('Leaderboard'),
//       ),
//       PopupMenuItem<String>(
//         onTap: () {
//           Get.to(() => SettingScreen());
//           // NavigationService.navigateTo(Routes.newSettingScreen);
//         },
//         value: 'Account Settings',
//         child: _buildMenuItem('Account Settings'),
//       ),
//       PopupMenuItem<String>(
//         value: 'FAQ',
//         child: _buildMenuItem('FAQ'),
//         onTap: () {
//           Get.to(() => FaqScreen());
//         },
//       ),
//       PopupMenuItem<String>(
//         value: 'Support',
//         onTap: () {
//           // Get.to(() => FaqScreen());
//         },
//         child: _buildMenuItem('Support'),
//       ),
//     ],
//     elevation: 8.0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20),
//         bottomLeft: Radius.circular(20),
//       ),
//     ),
//   );
// }
//
// Widget _buildMenuItem(String title) {
//   return Row(
//     children: [
//       Text(
//         title,
//         style: TextFontStyle.textStyle14Poppins4000c222222.copyWith(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   );
// }
