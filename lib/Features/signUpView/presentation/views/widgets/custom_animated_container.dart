import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    super.key,
    required this.image,
    required this.isActive,
    required this.text,
  });
  final String image;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 150,
      ),
      width: 150,
      height: 62,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: isActive ? kPrimaryColor : Colors.black.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? kPrimaryColor : Colors.white,
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kThirdColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                image,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: Styles.textStyleReg16,
            ),
          ],
        ),
      ),
    );
  }
}
