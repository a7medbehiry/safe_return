import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomLogOut extends StatelessWidget {
  const CustomLogOut({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35,
      child: Container(
        decoration: ShapeDecoration(
          color: kSecondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/profileEndDrawerPhotos/logout.svg'),
            const SizedBox(
              width: 5,
            ),
            Text(
              'log out',
              style: Styles.textStyleSemi16.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
