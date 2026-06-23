// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants/text_font_style.dart';

// class CustomAppbar extends StatefulWidget {
//   final Color appBarColor;
//   final String? title;
//   final Color circleColor;
//   final String leftIcon;
//   final String? rightIcon;
//   final bool? isRightIcon;
//   final bool? isLeftIcon;
//   final VoidCallback? onTap;
//   final VoidCallback backOnTap;

//   const CustomAppbar({
//     super.key,
//     required this.appBarColor,
//     this.title,
//     required this.leftIcon,
//     this.rightIcon,
//     required this.circleColor,
//     this.onTap,
//     this.isRightIcon = true,
//     required this.backOnTap,
//     this.isLeftIcon,
//   });

//   @override
//   State<CustomAppbar> createState() => _CustomAppbarState();
// }

// class _CustomAppbarState extends State<CustomAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.appBarColor,
//       height: 80.h,
//       child: Padding(
//         padding: EdgeInsets.only(top: 36.h, left: 16.w, right: 16.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: widget.backOnTap,
//               child: Container(
//                 height: 24.h,
//                 width: 37.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: widget.circleColor,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(6),
//                   child: Image.asset(
//                     widget.leftIcon,
//                     height: 15.h,
//                     width: 15.w,
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               widget.title ?? '',
//               style: TextFontStyle.textStyleMontserrarTegular.copyWith(
//                 fontWeight: FontWeight.w600,
//                 height: 0.0,
//               ),
//             ),
//             widget.isRightIcon! && widget.rightIcon != null
//                 ? GestureDetector(
//                   onTap: widget.onTap,
//                   child: Image.asset(
//                     widget.rightIcon!,
//                     height: 20.h,
//                     width: 20.w,
//                   ),
//                 )
//                 : SizedBox(width: 20.w),
//           ],
//         ),
//       ),
//     );
//   }
// }
