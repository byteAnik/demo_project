import 'package:flutter/material.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/constants/text_font_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationWidget extends StatefulWidget {
  final ValueChanged<dynamic>? onChanged;
  final ValueChanged<dynamic>? onCompleted;
  final ValueChanged<dynamic>? onSubmitted;
  final TextEditingController controller;

  final int length;

  const OtpVerificationWidget({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    required this.length,
    required this.controller,
  });

  @override
  State<OtpVerificationWidget> createState() => _OtpVerificationWidgetState();
}

class _OtpVerificationWidgetState extends State<OtpVerificationWidget> {
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: PinCodeTextField(
        enablePinAutofill: true,
        keyboardType: TextInputType.number,
        appContext: context,
        length: widget.length,
        animationType: AnimationType.fade,
        cursorColor: AppColors.c000000,
        pinTheme: PinTheme(
          activeBorderWidth: 1,
          selectedBorderWidth: 1,
          shape: PinCodeFieldShape.box,
          borderWidth: 0.5,
          borderRadius: BorderRadius.circular(4),
          disabledColor: AppColors.c000000,
          errorBorderColor: AppColors.c000000,
          fieldHeight: 51,
          fieldWidth: 52,
          activeFillColor: AppColors.c007CFA,
          inactiveFillColor: AppColors.c007CFA,
          selectedFillColor: AppColors.c007CFA,
          activeColor: AppColors.c007CFA, //const Color(0xFFF4F5F7),
          inactiveColor: Colors.blueGrey, // const Color(0xFFF4F5F7),
          selectedColor: AppColors.c007CFA,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: false,
        controller: widget.controller,
        onCompleted: widget.onCompleted ?? (value) {},
        onChanged: widget.onChanged ?? (value) {},
        onSubmitted: widget.onSubmitted ?? (value) {},
        textStyle: TextFontStyle.textStyle20Urbanist500c262626.copyWith(
          color: AppColors.c000000,
          fontSize: 16,
        ),
        // .copyWith(decoration: TextDecoration.underline)
      ),
    );
  }
}
