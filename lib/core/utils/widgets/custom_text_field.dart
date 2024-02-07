import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.width,
      required this.height});
  final String hintText;
  final Widget prefixIcon;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: width,
        height: height,
        child: TextField(
          style: Styles.textStyleReg16.copyWith(
            color: Colors.black,
          ),
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
