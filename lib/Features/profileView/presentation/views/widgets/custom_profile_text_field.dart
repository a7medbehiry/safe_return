import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';

import '../../../../../core/utils/styles.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.width,
    required this.height,
    this.onChanged,
    this.enabled = true,
    this.keyboardType,
    this.onTap,
    this.readOnly = false, this.controller,
  });
  final String hintText;
  final Widget prefixIcon;
  final double width, height;
  final bool enabled;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          style: Styles.textStyleSemi16.copyWith(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 100,
              ),
              child: SizedBox(
                width: 50,
                child: prefixIcon,
              ),
            ),
            prefixIconColor: kPrimaryColor,
            hintText: hintText,
            hintStyle: Styles.textStyleSemi16.copyWith(
              color: Colors.black,
            ),
            enabled: enabled,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
