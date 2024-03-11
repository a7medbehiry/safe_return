import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class CustomTextContainerWithRadius extends StatelessWidget {
  const CustomTextContainerWithRadius({
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
          borderRadius: BorderRadius.circular(16),
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
