import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // 🚀 flutter_map ইমপোর্ট করা হলো
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/auth/controller/driver_home_controller.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
import 'package:latlong2/latlong.dart';
// import 'package:gps_tracking_system_app/driver_home_controller.dart'; 

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  // ম্যাপের পজিশন লাইভ কন্ট্রোল করার জন্য MapController
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.find<DriverHomeController>();
    final String? currentUid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: currentUid == null
            ? const Center(child: Text("Driver login required"))
            : StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('active_vehicles')
                    .doc(currentUid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text("No vehicle streaming data found."));
                  }

                  var vehicleData = snapshot.data!.data() as Map<String, dynamic>;
                  String vehicleName = vehicleData['vehicleName'] ?? 'Toyota Axio';
                  bool isTracking = vehicleData['isTracking'] ?? false;
                  String speed = vehicleData['speed'] ?? '0 km/h';
                  
                  // 🎯 ফায়ারবেস থেকে লাইভ ল্যাটিচিউড ও লঙ্গিচিউড নেওয়া হচ্ছে
                  double lat = vehicleData['latitude'] ?? 23.7772;
                  double lng = vehicleData['longitude'] ?? 90.4009;
                  LatLng currentPosition = LatLng(lat, lng);

                  // 🔄 ডাটাবেজে জিপিএস কোঅর্ডিনেট চেঞ্জ হওয়ার সাথে সাথে ম্যাপের ক্যামেরা ওই লোকেশনে মুভ করবে
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _mapController.move(currentPosition, 16.0); // ১৬.০ জুম লেভেল
                  });

                  final List<Map<String, dynamic>> trackingDashboardData = [
                    {"label": "Speed", "value": speed, "isStatus": false},
                    {"label": "Status", "value": isTracking ? "Tracking" : "Stopped", "isStatus": true},
                    {"label": "Accuracy", "value": isTracking ? "3 m" : "10 m", "isStatus": false},
                  ];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UIHelper.kDefaulutPadding(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(20.h),

                        // ১. টপ ভেহিকেল স্ট্যাটাস প্যানেল
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              padding: EdgeInsets.all(4.w),
                              child: Image.asset(AssetsImages.carImage, fit: BoxFit.contain),
                            ),
                            UIHelper.horizontalSpace(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleName,
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A1A)),
                                  ),
                                  UIHelper.verticalSpace(2.h),
                                  Text(
                                    "Dhaka Metro-11-2233",
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: const Color(0xFF7F8C8D)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: isTracking ? const Color(0xFFE6F4EA) : const Color(0xFFFCE8E6), 
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                isTracking ? "Online" : "Offline",
                                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: isTracking ? const Color(0xFF137333) : const Color(0xFFC5221F)),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(16.h),

                        // ২. 🗺️ লাইভ Flutter Map (OpenStreetMap) কন্টেইনার
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: const Color(0xFFE9ECEF)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: FlutterMap(
                                mapController: _mapController,
                                options: MapOptions(
                                  initialCenter: currentPosition,
                                  initialZoom: 16.0,
                                ),
                                children: [
                                  // ওপেনস্ট্রিটম্যাপ এর লাইভ রেন্ডার টাইলস ল্যামিনেশন
                                  TileLayer(
                                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.gps_tracking_system_app',
                                  ),
                                  
                                  // 📌 ম্যাপের ওপর গাড়ির লাইভ মার্কার লেয়ার
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: currentPosition,
                                        width: 50.w,
                                        height: 50.w,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // গাড়ির পেছনে নীল লাইভ পালস এফেক্ট
                                            Container(
                                              width: 45.w,
                                              height: 45.w,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF2F6BFF).withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            // আপনার কাস্টম কার ইমেজ উইজেট
                                            Container(
                                              width: 32.w,
                                              height: 32.w,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  )
                                                ]
                                              ),
                                              padding: EdgeInsets.all(4.w),
                                              child: Image.asset(
                                                AssetsImages.carImage,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),

                        // ৩. বটম ট্র্যাকিং ডাটা ড্যাশবোর্ড
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.cFFFFFF,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: const Color(0xFFF1F3F4)),
                          ),
                          child: Row(
                            children: List.generate(
                              trackingDashboardData.length * 2 - 1, 
                              (index) {
                                if (index.isOdd) {
                                  return Container(height: 30.h, width: 1, color: const Color(0xFFE9ECEF));
                                }

                                final dataIndex = index ~/ 2;
                                final item = trackingDashboardData[dataIndex];

                                return Expanded(
                                  child: Column(
                                    children: [
                                      Text(item["label"], style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: const Color(0xFF7F8C8D))),
                                      UIHelper.verticalSpace(6.h),
                                      Text(
                                        item["value"],
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: item["isStatus"]
                                              ? (isTracking ? const Color(0xFF27AE60) : const Color(0xFFEA4335))
                                              : const Color(0xFF1A1A1A), 
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),

                        // ৪. Stop Tracking অ্যাকশন বাটন
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.stopTracking(); 
                              Get.back(); 
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEA4335), 
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            ),
                            child: Text("Stop Tracking", style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                        UIHelper.verticalSpace(20.h),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}