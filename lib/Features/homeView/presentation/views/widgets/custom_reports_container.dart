import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomReportsContainer extends StatelessWidget {
  const CustomReportsContainer({
    super.key,
    required this.image,
    this.onTap,
    required this.text,
  });
  final String image;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xffF3F6F6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  image,
                  height: 160,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: Styles.textStyleSemi16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
