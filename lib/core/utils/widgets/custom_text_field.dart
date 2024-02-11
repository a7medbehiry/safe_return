import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.width,
    required this.height,
    this.obscureText = false,
    this.onChanged,
    this.fillColor = const Color(0xffEEE8D8), this.onTap, this.controller,  this.readOnly = false, this.keyboardType, 
  });
  final String hintText;
  final Widget? prefixIcon;
  final double width, height;
  final bool obscureText;
  final Color fillColor;
  final void Function(String)? onChanged;
  final void Function()? onTap;
    final TextEditingController? controller;
      final bool readOnly;
        final TextInputType? keyboardType;




  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: Styles.textStyleReg16.copyWith(
          color: Colors.black,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
          fillColor: fillColor,
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
    );
  }
}
