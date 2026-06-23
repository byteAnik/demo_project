import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_assets/assets_image.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // সেটিংস লিস্টের জন্য ডামি ডাটা স্ট্রাকচার
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.person_outline,
        "title": "Personal Information",
        "trailing": "",
      },
      {
        "icon": Icons.credit_card_outlined,
        "title": "Payment Methods",
        "trailing": "",
      },
      {
        "icon": Icons.notifications_none_outlined,
        "title": "Notification Settings",
        "trailing": "",
      },
      {
        "icon": Icons.language_outlined,
        "title": "Language",
        "trailing": "English", // ডানপাশে টেক্সট দেখানোর জন্য
      },
      {
        "icon": Icons.help_outline_outlined,
        "title": "Help & Support",
        "trailing": "",
      },
      {"icon": Icons.info_outline, "title": "About Us", "trailing": ""},
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
                UIHelper.verticalSpace(20.h),

                // ১. টপ প্রোফাইল ব্লু কার্ড প্যানেল
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF2F6BFF,
                    ), // ইমেজের মতো ভাইব্রেন্ট ব্লু কালার
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      // সার্কুলার প্রোফাইল ইমেজ অবয়ব
                      Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2.w),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFE2E8F0),
                          backgroundImage: AssetImage(AssetsImages.anik),
                        ),
                      ),
                      UIHelper.horizontalSpace(16.w),

                      // ইউজার নেম এবং ফোন নম্বর সেকশন
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anik Biswa",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            UIHelper.verticalSpace(4.h),
                            Text(
                              "+880 1712-345678",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ডানপাশের কাস্টম এডিট প্রোফাইল বাটন আইকন
                      IconButton(
                        icon: Icon(
                          Icons
                              .edit_note_outlined, // ইমেজের এডিট বক্স আইকনটির মতো
                          color: Colors.white,
                          size: 26.sp,
                        ),
                        onPressed: () {
                          // প্রোফাইল এডিট অপশন অ্যাকশন
                        },
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(24.h),

                // ২. সেটিংস অপশন মেনু কন্টেইনার (বক্স শ্যাডো বর্ডার সহ)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFF1F3F4),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.015),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xFFF1F3F4),
                      height: 1,
                      thickness: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      final bool hasTrailingText = item['trailing'].isNotEmpty;

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 4.h,
                        ),
                        leading: Icon(
                          item['icon'],
                          color: const Color(
                            0xFF5F6368,
                          ), // স্ট্যান্ডার্ড গ্রে আইকন কালার
                          size: 22.sp,
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF202124),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (hasTrailingText)
                              Text(
                                item['trailing'],
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF7F8C8D),
                                ),
                              ),
                            if (hasTrailingText) UIHelper.horizontalSpace(4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.sp,
                              color: const Color(0xFFBCC1C6),
                            ),
                          ],
                        ),
                        onTap: () {
                          // প্রতিটি মেনুর নির্দিষ্ট পেজ নেভিগেশন এখানে হবে
                        },
                      );
                    },
                  ),
                ),

                UIHelper.verticalSpace(24.h),

                // ৩. লাল রঙের কাস্টম Logout বাটন
                InkWell(
                  onTap: () {
                    // লগআউট ফাংশনালিটি
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 8.w,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: const Color(0xFFEA4335), // আকর্ষণীয় রেড কালার
                          size: 22.sp,
                        ),
                        UIHelper.horizontalSpace(12.w),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEA4335),
                          ),
                        ),
                      ],
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
