import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class CommonTextFormField extends StatefulWidget {
  final String label;
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

  const CommonTextFormField({
    super.key,
    required this.label,
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
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword ? true : widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔥 LABEL
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.white.withOpacity(0.7),
          ),
        ),

        UIHelper.verticalSpace(8.h),

        /// 🔥 FIELD WRAPPER
        Container(
          height: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),

          child: TextFormField(
            focusNode: widget.focusNode,
            controller: widget.controller,

            /// 🔥 🔥 MAIN FIX
            textAlignVertical: TextAlignVertical.center,

            obscureText: widget.isPassword ? _isObscured : widget.obscureText,

            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            showCursor: widget.showCursor,
            onChanged: widget.onChanged,

            style: TextStyle(color: Colors.white, fontSize: 13.sp),

            decoration: InputDecoration(
              hintText: widget.hintText,

              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 13.sp,
              ),

              /// 🔥 PERFECT CENTER BALANCE
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),

              /// 🔥 PREFIX ICON
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6),
                            BlendMode.srcIn,
                          ),
                          child: widget.prefixIcon,
                        ),
                      ),
                    )
                  : null,

              prefixIconConstraints: BoxConstraints(minWidth: 40.w),

              /// 🔥 SUFFIX ICON (PASSWORD)
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.isPassword
                      ? Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white.withOpacity(0.5),
                              size: 18.sp,
                            ),
                            onPressed: _toggleVisibility,
                          ),
                        )
                      : null),

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
