import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/constants/text_font_style.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class CustomDropdownFlied extends StatefulWidget {
  final FocusNode? focusNode;
  final String hintText;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final bool showCursor;
  final Function(String)? onChanged;

  const CustomDropdownFlied({
    super.key,
    this.focusNode,
    required this.hintText,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.showCursor = true,
    this.onChanged,
  });

  @override
  State<CustomDropdownFlied> createState() => _CustomDropdownFliedState();
}

class _CustomDropdownFliedState extends State<CustomDropdownFlied> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpace(8.h),

        /// 🔹 Dropdown Container
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.cDFDFDF),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: true, // 🔴 dropdown behaviour
            onTap: widget.onTap,
            showCursor: false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextFontStyle.textStylec24cRobotoW600.copyWith(
                color: AppColors.cBEBEBE,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,

              /// 🔹 Dropdown Arrow
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 26.sp,
                  color: AppColors.cBEBEBE,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
