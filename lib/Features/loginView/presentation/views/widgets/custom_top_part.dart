import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/core/utils/widgets/custom_text_field.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/styles.dart';

class CustomTopPart extends StatelessWidget {
  const CustomTopPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 460,
        ),
        Positioned(
          top: 40,
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect3.svg',
          ),
        ),
        Positioned(
          left: -2,
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect2.svg',
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect1.svg',
          ),
        ),
        Positioned(
          left: 105,
          top: 45,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: .1,
              sigmaY: .1,
            ),
            child: Text(
              'Safe Return',
              style: Styles.textStyle32.copyWith(
                color: Colors.white.withOpacity(.85),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 190,
          child: Text(
            'Welcome!',
            style: Styles.textStyleSemi16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 230,
          child: CustomTextField(
            onChanged: (data) {},
            fillColor: const Color(0xffF3F6F6),
            width: 350,
            height: 60,
            hintText: 'Email',
            prefixIcon: const Icon(
              Icons.email,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 315,
          child: CustomTextField(
            onChanged: (data) {},
            fillColor: const Color(0xffF3F6F6),
            width: 350,
            height: 60,
            hintText: 'Password',
            obscureText: true,
            prefixIcon: const Icon(
              Icons.lock,
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 380,
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'Forget Password',
              style: Styles.textStyle12.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Positioned(
          left: 150,
          top: 420,
          child: CustomButton(
            onTap: () {},
            width: 96,
            height: 40,
            text: Text(
              'Log In',
              style: Styles.textStyleReg16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
