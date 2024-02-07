import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/loginView/presentation/views/widgets/custom_divider.dart';
import 'package:safe_return/Features/loginView/presentation/views/widgets/custom_facebook_logo.dart';
import 'package:safe_return/Features/loginView/presentation/views/widgets/custom_google_logo.dart';
import 'package:safe_return/Features/loginView/presentation/views/widgets/custom_sign_up_button.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_shield.dart';

class CustomBottomPart extends StatelessWidget {
  const CustomBottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 345,
        ),
        Positioned(
          bottom: 20,
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect3_reverse.svg',
          ),
        ),
        Positioned(
          right: -9,
          bottom: -15,
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect2_reverse.svg',
          ),
        ),
        Positioned(
          right: -2,
          bottom: -20,
          child: SvgPicture.asset(
            'assets/loginViewPhotos/rect1_reverse.svg',
          ),
        ),
        const Positioned(
          top: 30,
          child: CustomDivider(),
        ),
        Positioned(
          left: 145,
          top: 55,
          child: Text(
            'Continue With',
            style: Styles.textStyleMed15
                .copyWith(color: Colors.black.withOpacity(.6)),
          ),
        ),
        const Positioned(
          left: 115,
          top: 85,
          child: CustomFacebookLogo(),
        ),
        const Positioned(
          right: 110,
          top: 85,
          child: CustomGoogleLogo(),
        ),
        const Positioned(
          left: 105,
          top: 180,
          child: Text(
            'Don\'t have an account ?',
            style: Styles.textStyleReg16,
          ),
        ),
        const Positioned(
          left: 160,
          bottom: 93,
          child: CustomSignUpButton(),
        ),
        const Positioned(
          left: 30,
          bottom: 15,
          child: CustomShield(),
        ),
      ],
    );
  }
}
