import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/driver_navigation_bar_screen.dart';
import 'package:gps_tracking_system_app/features/driver_section_flow/auth/register/presentation/register_screen.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

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
                UIHelper.verticalSpace(24.h),

                // ওপরের ইলাস্ট্রেশন ইমেজ (আপনার আগের কোড অনুযায়ী)
                Center(
                  child: Image.asset(
                    AssetsImages.loginImage,
                    height: 180.h, // ইমেজের একটি ডিফল্ট হাইট দেওয়া হলো
                    fit: BoxFit.contain,
                  ),
                ),
                UIHelper.verticalSpace(32.h),

                // ওয়েলকাম টাইটেল এবং সাবটাইটেল
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      Text(
                        "Login to your driver account",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(32.h),

                // ১. Email or Phone ফিল্ড
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email or Phone",
                    hintStyle: TextStyle(
                      color: const Color(0xFF868E96),
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: const Color(0xFF5F6368),
                      size: 22.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFFE9ECEF),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF27AE60), // ফোকাস হলে গ্রিন কালার
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),

                // ২. Password ফিল্ড
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: const Color(0xFF868E96),
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: const Color(0xFF5F6368),
                      size: 22.sp,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF868E96),
                        size: 20.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFFE9ECEF),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF27AE60),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),

                // ৩. Forgot Password টেক্সট
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      // ফরগট পাসওয়ার্ড অ্যাকশন
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2F6BFF), // ব্লু কালার
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // ৪. Login বাটন (সবুজ রঙের)
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => DriverNavigationBarScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF27AE60,
                      ), // ইমেজের মতো সলিড গ্রিন
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),

                // ৫. Register লিঙ্ক
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7F8C8D),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => RegisterScreen());
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF27AE60), // গ্রিন কালার টেক্সট
                        ),
                      ),
                    ),
                  ],
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
