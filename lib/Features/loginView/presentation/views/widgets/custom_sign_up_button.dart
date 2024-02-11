import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/core/utils/styles.dart';

import '../../../../../constants.dart';

class CustomSignUpButton extends StatelessWidget {
  const CustomSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push('/signUpView');
      },
      child: Container(
        width: 64,
        height: 38,
        decoration: ShapeDecoration(
          color: kSecondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            'Sign Up',
            style: Styles.textStyle12.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
