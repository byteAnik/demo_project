import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // রিঅ্যাক্টিভ ভ্যারিয়েবল (লোকাল বাটন স্টেট ইনস্ট্যান্ট চেঞ্জ করার জন্য)
  var isTracking = false.obs;

  // ঢাকা মহাখালী জোন (সিমুলেশন স্টার্টিং পয়েন্ট)
  double currentLat = 23.7772;
  double currentLng = 90.4009;

  Timer? _simulationTimer;

  @override
  void onInit() {
    super.onInit();
    _checkAndInitializeDriverData();
  }

  // ড্রাইভার লগইন করার পর যদি ফায়ারস্টোরে কোনো ডাটা না থাকে, তবে একটি ডিফল্ট প্রোফাইল তৈরি করবে
  Future<void> _checkAndInitializeDriverData() async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid == null) return;

      DocumentSnapshot doc = await _firestore
          .collection('active_vehicles')
          .doc(uid)
          .get();

      // যদি এই UID দিয়ে ফায়ারস্টোরে আগে কোনো ডকুমেন্ট না থাকে
      if (!doc.exists) {
        await _firestore.collection('active_vehicles').doc(uid).set({
          'driverId': uid,
          'driverName': 'Anik Biswas',
          'vehicleName': 'Toyota Axio',
          'vehicleType':
              'car', // lowercase এ রাখা হলো ইউজার এন্ডের সাথে ম্যাচ করার জন্য
          'isTracking': false,
          'speed': '0 km/h',
          'latitude': currentLat,
          'longitude': currentLng,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      } else {
        // যদি ডকুমেন্ট থাকে, তবে কারেন্ট ট্র্যাকিং স্ট্যাটাস লোকাল স্টেট-এ সিঙ্ক করে নেওয়া
        var data = doc.data() as Map<String, dynamic>;
        isTracking.value = data['isTracking'] ?? false;
        currentLat = data['latitude'] ?? 23.7772;
        currentLng = data['longitude'] ?? 90.4009;
      }
    } catch (e) {
      debugPrint("Initialization Error: $e");
    }
  }

  // ফায়ারস্টোরে লোকেশন, স্পিড এবং হিস্ট্রি রিয়েল-টাইম আপডেট করার কোর ফাংশন
  Future<void> _updateFirebaseLocation() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final vehicleRef = _firestore.collection('active_vehicles').doc(uid);
      final speed = isTracking.value ? '45 km/h' : '0 km/h';
      final now = DateTime.now();
      final dateKey =
          '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      await vehicleRef.set({
        'driverId': uid,
        'isTracking': isTracking.value,
        'speed': speed,
        'latitude': currentLat,
        'longitude': currentLng,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await vehicleRef.collection('tracking_history').add({
        'driverId': uid,
        'dateKey': dateKey,
        'isTracking': isTracking.value,
        'speed': speed,
        'latitude': currentLat,
        'longitude': currentLng,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Firebase Update Error: $e");
    }
  }

  // ১. Start Tracking: সিমুলেশন শুরু করার মেথড
  void startTracking() {
    if (isTracking.value) {
      Get.snackbar(
        "Already Active",
        "Tracking simulation is already running.",
        backgroundColor: const Color(0xFFF1C40F),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isTracking.value = true;
    _updateFirebaseLocation();

    // প্রতি ৪ সেকেন্ড পর পর গাড়ি সামান্য এগিয়ে যাওয়ার ডামি লজিক
    _simulationTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      currentLat += 0.00015; // Latitude বৃদ্ধি
      currentLng += 0.00012; // Longitude বৃদ্ধি
      _updateFirebaseLocation();
    });

    Get.snackbar(
      "Tracking Started",
      "Live vehicle simulation broadcast is now active.",
      backgroundColor: const Color(0xFF27AE60),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ২. Stop Tracking: সিমুলেশন বন্ধ করার মেথড
  void stopTracking() {
    if (!isTracking.value) {
      Get.snackbar(
        "Already Offline",
        "Tracking is already stopped.",
        backgroundColor: const Color(0xFF7F8C8D),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isTracking.value = false;
    _simulationTimer?.cancel(); // ব্যাকগ্রাউন্ড টাইমার কিল করা
    _updateFirebaseLocation(); // ডাটাবেজে স্ট্যাটাস ইনঅ্যাক্টিভ করা

    Get.snackbar(
      "Tracking Stopped",
      "Vehicle simulation has been paused.",
      backgroundColor: const Color(0xFFEA4335),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    _simulationTimer?.cancel(); // মেমোরি লিক রোধ করতে টাইমার ডিসপোজ করা
    super.onClose();
  }
}
