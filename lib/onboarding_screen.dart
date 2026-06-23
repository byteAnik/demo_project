// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/route_manager.dart';
// import 'package:tally_khata/features/login/login_screen.dart';

// // ── Dummy List ────────────────────────────────────────────────────────────────
// final List<Map<String, dynamic>> onboardingList = [
//   {
//     "title": "ডিজিটাল খাতা",
//     "description":
//         "Replace your traditional paper notebook with a secure, digital tally khata. Track dues and payments effortlessly.",
//     "icon": _IconType.book,
//   },
//   {
//     "title": "স্মার্ট রিমাইন্ডার",
//     "description":
//         "Send automated SMS and WhatsApp reminders to customers. Never miss a payment again.",
//     "icon": _IconType.bell,
//   },
//   {
//     "title": "ব্যবসা বৃদ্ধি",
//     "description":
//         "Get detailed reports and insights to grow your business. Track income, expenses, and customer trends.",
//     "icon": _IconType.trendingUp,
//   },
// ];

// // ── Enum ──────────────────────────────────────────────────────────────────────
// enum _IconType { book, bell, trendingUp }

// // ── Screen ───────────────────────────────────────────────────────────────────
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _ctrl = PageController();

//   int _page = 0;

//   void _next() {
//     if (_page < onboardingList.length - 1) {
//       _ctrl.nextPage(
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       Get.to(() => LoginScreen());
//     }
//   }

//   void _skip() {
//     _ctrl.animateToPage(
//       onboardingList.length - 1,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//     );

//     final data = onboardingList[_page];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               // ── Top illustration ────────────────────────────────────────────
//               SizedBox(
//                 height: 0.50.sh,
//                 width: double.infinity,
//                 child: PageView.builder(
//                   controller: _ctrl,
//                   itemCount: onboardingList.length,
//                   onPageChanged: (value) {
//                     setState(() {
//                       _page = value;
//                     });
//                   },
//                   itemBuilder: (_, index) {
//                     return _IllustrationArea(
//                       icon: onboardingList[index]["icon"],
//                     );
//                   },
//                 ),
//               ),

//               // ── Bottom Content ─────────────────────────────────────────────
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 28.h),

//                       // ── Indicator ────────────────────────────────────────
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(onboardingList.length, (index) {
//                           final isActive = index == _page;

//                           return AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             margin: EdgeInsets.symmetric(horizontal: 4.w),
//                             width: isActive ? 24.w : 8.w,
//                             height: 8.h,
//                             decoration: BoxDecoration(
//                               color: isActive
//                                   ? const Color(0xFF1AAB61)
//                                   : const Color(0xFFD0D0D0),
//                               borderRadius: BorderRadius.circular(4.r),
//                             ),
//                           );
//                         }),
//                       ),

//                       SizedBox(height: 20.h),

//                       // ── Title ────────────────────────────────────────────
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 250),
//                         child: Text(
//                           data["title"],
//                           key: ValueKey(data["title"]),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 26.sp,
//                             fontWeight: FontWeight.w800,
//                             color: const Color(0xFF0D1B2A),
//                             height: 1.3,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 12.h),

//                       // ── Description ──────────────────────────────────────
//                       AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 250),
//                         child: Text(
//                           data["description"],
//                           key: ValueKey(data["description"]),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                             color: const Color(0xFF6B7280),
//                             height: 1.65,
//                           ),
//                         ),
//                       ),

//                       const Spacer(),

//                       // ── Button ───────────────────────────────────────────
//                       SizedBox(
//                         width: double.infinity,
//                         height: 54.h,
//                         child: ElevatedButton(
//                           onPressed: _next,
//                           style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             backgroundColor: const Color(0xFF1B6B45),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14.r),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 _page == onboardingList.length - 1
//                                     ? 'Get Started'
//                                     : 'Next',
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               SizedBox(width: 8.w),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.white,
//                                 size: 18.sp,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 36.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // ── Skip ───────────────────────────────────────────────────────────
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 12.h,
//             right: 20.w,
//             child: GestureDetector(
//               onTap: _skip,
//               child: Padding(
//                 padding: EdgeInsets.all(8.r),
//                 child: Text(
//                   'Skip',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Illustration Area ─────────────────────────────────────────────────────────
// class _IllustrationArea extends StatelessWidget {
//   final _IconType icon;

//   const _IllustrationArea({required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.hardEdge,
//       children: [
//         Container(color: const Color(0xFFECF8F2)),

//         Positioned(top: -60, right: -60, child: _Blob(size: 210.w)),

//         Positioned(bottom: -60, left: -60, child: _Blob(size: 210.w)),

//         Center(
//           child: Container(
//             width: 190.w,
//             height: 190.w,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 50,
//                   spreadRadius: 12,
//                   color: const Color(0xFF22C55E).withOpacity(0.18),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: CustomPaint(
//                 size: Size(76.w, 76.w),
//                 painter: _IconPainter(icon),
//               ),
//             ),
//           ),
//         ),

//         Positioned(
//           top: 0.16.sh,
//           right: 36.w,
//           child: const _Badge(
//             label: '৳ Due',
//             bg: Color(0xFFFEE2E2),
//             fg: Color(0xFFDC2626),
//           ),
//         ),

//         Positioned(
//           bottom: 0.05.sh,
//           left: 24.w,
//           child: const _Badge(
//             label: '৳ Paid',
//             bg: Color(0xFF1AAB61),
//             fg: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Blob ──────────────────────────────────────────────────────────────────────
// class _Blob extends StatelessWidget {
//   final double size;

//   const _Blob({required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             const Color(0xFF22C55E).withOpacity(0.30),
//             const Color(0xFF22C55E).withOpacity(0.0),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Badge ─────────────────────────────────────────────────────────────────────
// class _Badge extends StatelessWidget {
//   final String label;
//   final Color bg;
//   final Color fg;

//   const _Badge({required this.label, required this.bg, required this.fg});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//             color: Colors.black.withOpacity(0.10),
//           ),
//         ],
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 13.sp,
//           fontWeight: FontWeight.w600,
//           color: fg,
//         ),
//       ),
//     );
//   }
// }

// // ── Icon Painter ──────────────────────────────────────────────────────────────
// class _IconPainter extends CustomPainter {
//   final _IconType type;

//   _IconPainter(this.type);

//   Paint get _p => Paint()
//     ..color = const Color(0xFF1AAB61)
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 4
//     ..strokeCap = StrokeCap.round
//     ..strokeJoin = StrokeJoin.round;

//   @override
//   void paint(Canvas canvas, Size s) {
//     switch (type) {
//       case _IconType.book:
//         _book(canvas, s);

//       case _IconType.bell:
//         _bell(canvas, s);

//       case _IconType.trendingUp:
//         _trend(canvas, s);
//     }
//   }

//   void _book(Canvas canvas, Size s) {
//     final w = s.width;
//     final h = s.height;

//     canvas.drawPath(
//       Path()
//         ..moveTo(w * .50, h * .78)
//         ..lineTo(w * .50, h * .20)
//         ..cubicTo(w * .40, h * .13, w * .10, h * .15, w * .10, h * .34)
//         ..lineTo(w * .10, h * .78)
//         ..cubicTo(w * .10, h * .78, w * .24, h * .72, w * .50, h * .78),
//       _p,
//     );

//     canvas.drawPath(
//       Path()
//         ..moveTo(w * .50, h * .78)
//         ..lineTo(w * .50, h * .20)
//         ..cubicTo(w * .60, h * .13, w * .90, h * .15, w * .90, h * .34)
//         ..lineTo(w * .90, h * .78)
//         ..cubicTo(w * .90, h * .78, w * .76, h * .72, w * .50, h * .78),
//       _p,
//     );
//   }

//   void _bell(Canvas canvas, Size s) {
//     final w = s.width;
//     final h = s.height;

//     canvas.drawPath(
//       Path()
//         ..moveTo(w * .18, h * .70)
//         ..lineTo(w * .82, h * .70)
//         ..lineTo(w * .82, h * .52)
//         ..cubicTo(w * .82, h * .28, w * .62, h * .12, w * .50, h * .12)
//         ..cubicTo(w * .38, h * .12, w * .18, h * .28, w * .18, h * .52)
//         ..close(),
//       _p,
//     );

//     canvas.drawArc(
//       Rect.fromCenter(
//         center: Offset(w * .50, h * .76),
//         width: w * .26,
//         height: h * .14,
//       ),
//       0,
//       math.pi,
//       false,
//       _p,
//     );

//     final fillP = Paint()
//       ..color = const Color(0xFF1AAB61)
//       ..style = PaintingStyle.fill;

//     canvas.drawLine(Offset(w * .50, h * .04), Offset(w * .50, h * .12), _p);

//     canvas.drawCircle(Offset(w * .50, h * .04), w * .04, fillP);
//   }

//   void _trend(Canvas canvas, Size s) {
//     final w = s.width;
//     final h = s.height;

//     canvas.drawPath(
//       Path()
//         ..moveTo(w * .06, h * .74)
//         ..lineTo(w * .30, h * .52)
//         ..lineTo(w * .52, h * .64)
//         ..lineTo(w * .92, h * .26),
//       _p,
//     );

//     canvas.drawLine(Offset(w * .72, h * .20), Offset(w * .92, h * .26), _p);

//     canvas.drawLine(Offset(w * .90, h * .44), Offset(w * .92, h * .26), _p);
//   }

//   @override
//   bool shouldRepaint(covariant _IconPainter old) {
//     return old.type != type;
//   }
// }
