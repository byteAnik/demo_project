import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_tracking_system_app/common_wigdets/custom_textform_flield.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';
import 'package:intl/intl.dart';

class DriverAddVechileScreen extends StatefulWidget {
  const DriverAddVechileScreen({super.key});

  @override
  State<DriverAddVechileScreen> createState() => _DriverAddVechileScreenState();
}

class _DriverAddVechileScreenState extends State<DriverAddVechileScreen> {
  final _vehicleNameController = TextEditingController();
  final _numberPlateController = TextEditingController();
  bool _isSaving = false;

  // সিলেক্টেড ভেহিকেল টাইপ ট্র্যাক করার জন্য ভেরিয়েবল
  int _selectedVehicleIndex = 0;

  // গ্রিডের জন্য ডামি ভেহিকেল টাইপ লিস্ট
  final List<Map<String, dynamic>> _vehicleTypes = [
    {
      "name": "Car",
      "icon": Icons.directions_car,
      "color": const Color(0xFF2F6BFF),
    },
    {
      "name": "Motorcycle",
      "icon": Icons.motorcycle,
      "color": const Color(0xFFEA4335),
    },
    {
      "name": "Rickshaw",
      "icon": Icons.electric_rickshaw,
      "color": const Color(0xFF27AE60),
    },
    {"name": "CNG", "icon": Icons.local_taxi, "color": const Color(0xFFFF9900)},
    {
      "name": "Delivery",
      "icon": Icons.local_shipping,
      "color": const Color(0xFF9B51E0),
    },
    {
      "name": "Other",
      "icon": Icons.more_horiz,
      "color": const Color(0xFF7F8C8D),
    },
  ];

  @override
  void dispose() {
    _vehicleNameController.dispose();
    _numberPlateController.dispose();
    super.dispose();
  }

  Future<void> _saveVehicle() async {
    final vehicleName = _vehicleNameController.text.trim();
    final numberPlate = _numberPlateController.text.trim();

    if (vehicleName.isEmpty || numberPlate.isEmpty) {
      _showMessage('Add Vehicle', 'Please fill up all vehicle fields.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showMessage('Add Vehicle', 'Driver not logged in.');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final selectedVehicle = _vehicleTypes[_selectedVehicleIndex];
      final driverName =
          user.displayName ??
          user.email?.split('@').first.trim() ??
          'Unknown Driver';

      await FirebaseFirestore.instance
          .collection('active_vehicles')
          .doc(user.uid)
          .set({
            'driverId': user.uid,
            'driverName': driverName,
            'driverPhone': user.phoneNumber ?? '',
            'vehicleName': vehicleName,
            'vehicleType': selectedVehicle['name'],
            'numberPlate': numberPlate,
            'registeredOn': DateFormat('dd MMM yyyy').format(DateTime.now()),
            'isTracking': false,
            'speed': '0 km/h',
            'latitude': 23.7772,
            'longitude': 90.4009,
            'lastUpdated': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      if (!mounted) return;

      _vehicleNameController.clear();
      _numberPlateController.clear();
      _showMessage('Success', 'Vehicle added successfully.');
      Navigator.pop(context);
    } catch (error) {
      _showMessage('Add Vehicle', 'Failed to save vehicle. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  String? _requiredFieldValidator(String? value) {
    if ((value ?? '').trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(20.h),

                // ১. কাস্টম অ্যাপবার রো (Back Button & Title)
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20.sp,
                        color: const Color(0xFF1A1A1A),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const Spacer(),
                    Text(
                      "Add Vehicle",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const Spacer(),
                    // ব্যালেন্স বজায় রাখার জন্য খালি সাইজডবক্স
                    SizedBox(width: 20.w),
                  ],
                ),
                UIHelper.verticalSpace(30.h),

                // ২. Vehicle Name ইনপুট ফিল্ড (কাস্টম উইজেট ব্যবহার করা হয়েছে)
                CommonTextField(
                  labelText: 'Vehicle Name',
                  hintText: 'e.g. Toyota Axio',
                  controller: _vehicleNameController,
                  validator: _requiredFieldValidator,
                ),
                UIHelper.verticalSpace(20.h),

                // ৩. Number Plate ইনপুট ফিল্ড (কাস্টম উইজেট ব্যবহার করা হয়েছে)
                CommonTextField(
                  labelText: 'Number Plate',
                  hintText: 'e.g. Dhaka Metro-11-2233',
                  controller: _numberPlateController,
                  validator: _requiredFieldValidator,
                ),
                UIHelper.verticalSpace(20.h),

                // ৪. Vehicle Type ড্রপডাউন সেকশন
                Text(
                  "Vehicle Type",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                DropdownButtonFormField<int>(
                  key: ValueKey(_selectedVehicleIndex),
                  initialValue: _selectedVehicleIndex,
                  dropdownColor: AppColors.cFFFFFF,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xFF495057),
                    size: 22.sp,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFFE9ECEF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF27AE60)),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF495057),
                    fontWeight: FontWeight.w500,
                  ),
                  items: List.generate(_vehicleTypes.length, (index) {
                    final item = _vehicleTypes[index];
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Row(
                        children: [
                          Icon(item["icon"], size: 20.sp, color: item["color"]),
                          UIHelper.horizontalSpace(10.w),
                          Text(item["name"]),
                        ],
                      ),
                    );
                  }),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedVehicleIndex = value;
                    });
                  },
                ),
                UIHelper.verticalSpace(24.h),

                // ৫. ভেহিকেল টাইপ গ্রিড (৬টি আইটেম ২ কলামে)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _vehicleTypes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 1, // স্কয়ার বক্সের জন্য
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedVehicleIndex == index;
                    final item = _vehicleTypes[index];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedVehicleIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEDF2F7)
                              : AppColors.cFFFFFF,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF2F6BFF)
                                : const Color(0xFFE9ECEF),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item["icon"],
                              size: 28.sp,
                              color: item["color"],
                            ),
                            UIHelper.verticalSpace(8.h),
                            Text(
                              item["name"],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFF2F6BFF)
                                    : const Color(0xFF495057),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                UIHelper.verticalSpace(40.h),

                // ৬. Save Vehicle বাটন
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveVehicle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF27AE60,
                      ), // সলিড গ্রিন কালার
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: _isSaving
                        ? SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Save Vehicle",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
