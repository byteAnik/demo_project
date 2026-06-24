import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ১. ইমেজের সাথে মিল রেখে সেটিংস লিস্টের জন্য ডামি ডাটা স্ট্রাকচার
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.person_outline,
        "title": "Personal Information",
      },
      {
        "icon": Icons.lock_open_outlined,
        "title": "Change Password",
      },
      {
        "icon": Icons.notifications_none_outlined,
        "title": "Notification Settings",
      },
      {
        "icon": Icons.help_outline_outlined,
        "title": "Help & Support",
      },
    ];

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
                UIHelper.verticalSpace(10.h),

                // কাস্টম ব্যাক বাটন রো
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: const Color(0xFF1A1A1A)),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(10.h),

                // ২. টপ প্রোফাইল সেকশন (ইমেজ অনুযায়ী ক্লিন সেন্টারড ডিজাইন)
                Center(
                  child: Column(
                    children: [
                      // সার্কুলার প্রোফাইল ইমেজ (বর্ডার বা কন্টেইনার ছাড়া সরাসরি ইমেজের মতো)
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: const Color(0xFFE2E8F0),
                        backgroundImage: AssetImage(AssetsImages.anik),
                      ),
                      UIHelper.verticalSpace(16.h),

                      // ইউজার নেম
                      Text(
                        "Anik Biswas",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      UIHelper.verticalSpace(4.h),

                      // ড্রাইভার আইডি সেকশন
                      Text(
                        "Driver ID: DRV12345",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7F8C8D),
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(30.h),

                // ৩. সেটিংস অপশন মেনু লিস্ট (ListView.builder দিয়ে তৈরি, কোনো আউটলাইন বক্স শ্যাডো ছাড়া)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];

                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F3F4),
                            width: 1,
                          ),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        leading: Icon(
                          item['icon'],
                          color: const Color(0xFF5F6368),
                          size: 22.sp,
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: const Color(0xFFBCC1C6),
                        ),
                        onTap: () {
                          // নেভিগেশন অ্যাকশন
                        },
                      ),
                    );
                  },
                ),

                // ৪. ইমেজের মতো কাস্টম ডেকোরেশন ছাড়া ডিরেক্ট Logout বাটন রো
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFF1F3F4),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 6.h,
                    ),
                    onTap: () {
                      // লগআউট ফাংশনালিটি
                    },
                    leading: Icon(
                      Icons.logout_rounded,
                      color: const Color(0xFFEA4335),
                      size: 22.sp,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEA4335),
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}