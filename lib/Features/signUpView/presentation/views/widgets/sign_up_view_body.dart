import 'package:flutter/material.dart';
import 'package:safe_return/Features/signUpView/presentation/views/widgets/custom_animated_container_activation.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_text_field.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import 'custom_sign_up_date.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              onChanged: (data) {},
              hintText: 'First Name',
              width: 160,
              height: 45,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomTextField(
              onChanged: (data) {},
              hintText: 'Last Name',
              width: 160,
              height: 45,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const CustomSignUpDate(),
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CustomAnimatedContainerActivation(),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          onChanged: (data) {},
          hintText: 'Email',
          width: 330,
          height: 45,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          onChanged: (data) {},
          hintText: 'Password',
          width: 330,
          height: 45,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextField(
          onChanged: (data) {},
          hintText: 'Confirm Password',
          width: 330,
          height: 45,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          width: 330,
          height: 45,
          text: Text(
            'Create account',
            style: Styles.textStyleSemi14.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 260),
          child: CustomButton(
            onTap: () => Navigator.of(context).pop(),
            width: 65,
            height: 32,
            text: Text(
              'Back',
              style: Styles.textStyleReg13.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 110,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: CustomShield(),
        )
      ],
    );
  }
}
