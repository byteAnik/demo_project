// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gps_tracking_system_app/constants/app_colors.dart';
import 'package:gps_tracking_system_app/helpers/ui_helpers.dart';

class MyCustomDropdown extends StatefulWidget {
  final String? selectedValue;
  final List<String> dropDownValue;
  final Function(String?)? onTap;
  final double horizonPadding;
  final double verticPadding;
  final String? hinttext;
  final String? hintIcon;
  final bool isImageNull;
  final bool isIcon;
  final Color borderCalor;
  final TextStyle? hintTextStyle;
  final bool? theme;

  const MyCustomDropdown({
    super.key,
    this.selectedValue,
    required this.dropDownValue,
    this.horizonPadding = 15,
    this.verticPadding = 3,
    this.hinttext,
    this.onTap,
    this.hintIcon,
    required this.isImageNull,
    required this.isIcon,
    required this.borderCalor,
    this.hintTextStyle,
    this.theme,
  });

  @override
  _MyCustomDropdownState createState() => _MyCustomDropdownState();
}

class _MyCustomDropdownState extends State<MyCustomDropdown> {
  final FocusNode _focusNode = FocusNode();
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _focusNode;
    _focusNode.addListener(_onFocusChange);
    //_selectedValue = widget.selectedValue;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Focus(
        focusNode: _focusNode,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: AppColors.allPrimaryColor,
            border: Border.all(color: const Color(0xffC0C0C0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: widget.isIcon
                  ? Row(
                      children: [
                        Image.asset(
                          widget.hintIcon!,
                          width: widget.isImageNull ? 0 : 26,
                        ),
                        UIHelper.horizontalSpace(10),
                        Text(
                          "${widget.hinttext}",
                          style: widget.hintTextStyle,
                          // style: TextFontStyle.headline10w400c838484StyleTouche,
                        ),
                      ],
                    )
                  : Text("${widget.hinttext}", style: widget.hintTextStyle),
              isExpanded: true,
              value: _selectedValue,
              icon: Icon(Icons.keyboard_arrow_down, size: 22),
              items: widget.dropDownValue.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: widget.hintTextStyle,

                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue; // Update the selected value.
                });
                widget.onTap?.call(newValue);
                FocusScope.of(context).requestFocus(_focusNode);
              },
              // dropdownColor: AppColors.cFFFFFF,
            ),
          ),
        ),
      ),
    );
  }
}
