import 'package:flutter/material.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/constants/text_font_style.dart';

// ignore: strict_top_level_inference
SizedBox playButton({onTap, text}) {
  return SizedBox(
    height: 100,
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cD8D5EA,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                text ?? 'PLAY',
                style: TextFontStyle.textStyle20Urbanist500c262626,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
