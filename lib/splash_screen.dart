// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:tally_khata/onboarding_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Make status bar transparent so green fills the entire screen
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
//       ),
//     );
//     // inside initState of SplashScreen, after animation forward:
//     Future.delayed(const Duration(seconds: 3), () {
//       Get.off(() => const OnboardingScreen());
//     });

//     _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1AAB61),
//       body: SafeArea(
//         top: false,
//         child: Stack(
//           children: [
//             // ── Center content: logo + Bengali title + subtitle ──
//             Center(
//               child: AnimatedBuilder(
//                 animation: _animationController,
//                 builder: (context, child) {
//                   return FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: ScaleTransition(
//                       scale: _scaleAnimation,
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // ── App Icon ──
//                     Container(
//                       width: 88.w,
//                       height: 88.w,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.r),
//                       ),
//                       child: Center(child: _BookPlusIcon(size: 52.w)),
//                     ),

//                     SizedBox(height: 20.h),

//                     // ── Bengali App Name ──
//                     Text(
//                       'বাকিখাতা',
//                       style: TextStyle(
//                         fontFamily: 'Hind Siliguri',
//                         fontSize: 36.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         height: 1.2,
//                       ),
//                     ),

//                     SizedBox(height: 6.h),

//                     // ── English subtitle ──
//                     Text(
//                       'BakiKhata',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // ── Bottom: loading indicator + safe & secure label ──
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 40.h,
//               child: AnimatedBuilder(
//                 animation: _fadeAnimation,
//                 builder: (context, child) =>
//                     Opacity(opacity: _fadeAnimation.value, child: child),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Circular outlined loading indicator
//                     SizedBox(
//                       width: 28.w,
//                       height: 28.w,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 1.8,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                         backgroundColor: Colors.white.withOpacity(0.30),
//                       ),
//                     ),

//                     SizedBox(height: 12.h),

//                     // "100% Safe & Secure"
//                     Text(
//                       '100% Safe & Secure',
//                       style: TextStyle(
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white,
//                         letterSpacing: 0.3,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Custom painter that draws the book-with-plus icon using Flutter primitives,
// /// matching the rounded-square book icon with a medical-cross symbol shown
// /// in the design image.
// class _BookPlusIcon extends StatelessWidget {
//   final double size;
//   const _BookPlusIcon({required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(size: Size(size, size), painter: _BookIconPainter());
//   }
// }

// class _BookIconPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF1AAB61)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.07
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round;

//     final fillPaint = Paint()
//       ..color = const Color(0xFF1AAB61)
//       ..style = PaintingStyle.fill;

//     final double w = size.width;
//     final double h = size.height;
//     final double r = w * 0.12; // corner radius for the book outline

//     // ── Book outer shape (rounded rectangle) ──
//     final bookRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(w * 0.08, h * 0.06, w * 0.84, h * 0.88),
//       Radius.circular(r),
//     );
//     canvas.drawRRect(bookRect, paint);

//     // ── Spine line (vertical, left side inner) ──
//     canvas.drawLine(
//       Offset(w * 0.30, h * 0.06),
//       Offset(w * 0.30, h * 0.94),
//       paint,
//     );

//     // ── Plus / Cross icon (centered in right portion) ──
//     final double crossCx = w * 0.62;
//     final double crossCy = h * 0.42;
//     final double crossArm = w * 0.14;
//     final double crossThick = w * 0.065;

//     final crossPaint = Paint()
//       ..color = const Color(0xFF1AAB61)
//       ..style = PaintingStyle.fill;

//     // Horizontal bar
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromCenter(
//           center: Offset(crossCx, crossCy),
//           width: crossArm * 2,
//           height: crossThick,
//         ),
//         Radius.circular(crossThick / 2),
//       ),
//       crossPaint,
//     );

//     // Vertical bar
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//         Rect.fromCenter(
//           center: Offset(crossCx, crossCy),
//           width: crossThick,
//           height: crossArm * 2,
//         ),
//         Radius.circular(crossThick / 2),
//       ),
//       crossPaint,
//     );

//     // ── Small horizontal lines (book pages) at bottom-right portion ──
//     final linePaint = Paint()
//       ..color = const Color(0xFF1AAB61)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.055
//       ..strokeCap = StrokeCap.round;

//     final double lineX1 = w * 0.38;
//     final double lineX2 = w * 0.82;

//     canvas.drawLine(
//       Offset(lineX1, h * 0.68),
//       Offset(lineX2, h * 0.68),
//       linePaint,
//     );
//     canvas.drawLine(
//       Offset(lineX1, h * 0.80),
//       Offset(lineX2, h * 0.80),
//       linePaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
