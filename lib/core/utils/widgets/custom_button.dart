import 'package:flutter/material.dart';
import '../../../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    this.onTap,
    required this.text, this.color = kPrimaryColor,
  });
  final double width, height;
  final void Function()? onTap;
  final Color color;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
