import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class CustomTextContainer extends StatelessWidget {
  const CustomTextContainer({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.style,
  });
  final double width, height;
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: kSecondColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
