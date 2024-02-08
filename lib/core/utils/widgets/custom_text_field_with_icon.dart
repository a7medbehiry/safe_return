import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  const CustomTextFieldWithIcon({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.width,
    required this.height,
    this.obscureText = false, this.onChanged,
  });
  final String hintText;
  final Widget prefixIcon;
  final double width, height;
  final bool obscureText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          onChanged: onChanged,
          style: Styles.textStyleReg16.copyWith(
            color: Colors.black,
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: const Color(0xffF3F6F6),
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            prefixIcon: prefixIcon,
            prefixIconColor: kPrimaryColor,
            hintText: hintText,
            hintStyle: Styles.textStyleReg16.copyWith(
              color: Colors.black,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}