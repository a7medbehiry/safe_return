import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/styles.dart';

class CustomGoogleLogo extends StatelessWidget {
  const CustomGoogleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/loginViewPhotos/google.svg',
          ),
          const Text(
            'Google',
            style: Styles.textStyleReg14,
          ),
        ],
      ),
    );
  }
}
