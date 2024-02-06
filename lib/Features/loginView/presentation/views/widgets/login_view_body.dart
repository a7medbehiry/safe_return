import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_return/core/utils/styles.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: 40,
          child: SvgPicture.asset(
            'assets/loginViewPhoto/rect3.svg',
          ),
        ),
        Positioned(
          left: -2,
          child: SvgPicture.asset(
            'assets/loginViewPhoto/rect2.svg',
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/loginViewPhoto/rect1.svg',
          ),
        ),
        Positioned(
            left: 105,
            top: 45,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: .1, sigmaY: .1),
              child: Text(
                'Safe Return',
                style: Styles.textStyle32.copyWith(
                  color: Colors.white.withOpacity(.85),
                ),
              ),
            )),
      ],
    );
  }
}
