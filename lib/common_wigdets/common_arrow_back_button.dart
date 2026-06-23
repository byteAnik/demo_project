// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stress_detection_app/constants/app_assets/assets_icons.dart';
// import 'package:stress_detection_app/constants/app_colors.dart';

// class CommonArrowBackButton extends StatelessWidget {
//   final VoidCallback? onTap;

//   const CommonArrowBackButton({super.key, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap ?? () => Navigator.pop(context),
//       child: Container(
//         padding: EdgeInsets.all(5.w),
//         decoration: BoxDecoration(
//           color: AppColors.c341539,
//           borderRadius: BorderRadius.circular(33.r),
//         ),
//         child: Image.asset(
//           AssetsIcons.arrowBackIcon,
//           height: 21.h,
//           width: 21.w,
//         ),
//       ),
//     );
//   }
// }
