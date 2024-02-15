import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_profile_date.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';

import 'custom_profile_text_field.dart';

class CustomProfileTextFieldCondition extends StatefulWidget {
  const CustomProfileTextFieldCondition(
      {super.key, required this.isImageEnabled, required this.onButtonClicked});
  final bool isImageEnabled;
  final VoidCallback onButtonClicked;

  @override
  State<CustomProfileTextFieldCondition> createState() =>
      _CustomProfileTextFieldConditionState();
}

class _CustomProfileTextFieldConditionState
    extends State<CustomProfileTextFieldCondition> {
  bool isTextFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        CustomProfileTextField(
          enabled: isTextFieldEnabled,
          hintText: 'Ahmed Behiry',
          prefixIcon: Center(
            child: SvgPicture.asset(
              'assets/profileViewPhotos/person.svg',
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 36,
        ),
        const SizedBox(
          height: 22,
        ),
        CustomProfileTextField(
          enabled: isTextFieldEnabled,
          keyboardType: TextInputType.phone,
          hintText: '01102485400',
          prefixIcon: Center(
            child: SvgPicture.asset(
              'assets/profileViewPhotos/phone.svg',
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 36,
        ),
        const SizedBox(
          height: 22,
        ),
        CustomProfileTextField(
          enabled: isTextFieldEnabled,
          hintText: 'Egypt, Alexandria',
          prefixIcon: Center(
            child: SvgPicture.asset(
              'assets/profileViewPhotos/location.svg',
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 36,
        ),
        const SizedBox(
          height: 22,
        ),
        CustomProfileDate(
          enabled: isTextFieldEnabled,
        ),
        const SizedBox(
          height: 22,
        ),
        CustomProfileTextField(
          enabled: isTextFieldEnabled,
          hintText: 'amb@gmail.com',
          prefixIcon: Center(
            child: SvgPicture.asset('assets/profileViewPhotos/mail.svg'),
          ),
          width: MediaQuery.of(context).size.width,
          height: 36,
        ),
        const SizedBox(
          height: 33,
        ),
        CustomButton(
          onTap: () {
            setState(() {
              isTextFieldEnabled = !isTextFieldEnabled;
              widget.onButtonClicked();
            });
          },
          width: 105,
          height: 44,
          text: Text(
            'Edit Profile',
            style: Styles.textStyleSemi16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
