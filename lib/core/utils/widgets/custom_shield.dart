import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles.dart';

class CustomShield extends StatelessWidget {
  const CustomShield({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/shield.svg',
          height: 16,
        ),
        const SizedBox(
          width: 2,
        ),
        const Text(
          'Always there to help',
          style: Styles.textStyle8,
        )
      ],
    );
  }
}
