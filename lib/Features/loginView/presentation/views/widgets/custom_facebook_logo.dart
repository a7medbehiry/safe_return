import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/styles.dart';

class CustomFacebookLogo extends StatelessWidget {
  const CustomFacebookLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child:  Column(
        children: [
          SvgPicture.asset(
            'assets/loginViewPhotos/facebook.svg',
          ),
          const Text(
            'Facebook',
            style: Styles.textStyleReg14,
          ),
        ],
      ),
    );
  }
}
