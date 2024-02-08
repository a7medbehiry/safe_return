import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../styles.dart';

class CustomTextFieldWithOutIcon extends StatelessWidget {
  const CustomTextFieldWithOutIcon({
    super.key,
    required this.width,
    required this.height,
    required this.hintText, this.onChanged,
  });
  final double width, height;
  final String hintText;
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
