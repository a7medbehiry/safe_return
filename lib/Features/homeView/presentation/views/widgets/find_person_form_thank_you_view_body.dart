import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import 'custom_text_container_with_radius.dart';

class FindPersonFormThankYouViewBody extends StatelessWidget {
  const FindPersonFormThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Safe Return',
          style: Styles.textStyle32,
        ),
        const Image(
          image: AssetImage('assets/thankYouPhotos/animation.gif'),
        ),
        CustomTextContainerWithRadius(
          width: 300,
          height: 40,
          text: 'The request was completed successfully',
          style: Styles.textStyleMed13.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'We thank you.',
          style: Styles.textStyleMed15,
        ),
        const Text(
          'The organization will contact you now',
          style: Styles.textStyleMed15,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          onTap: () {
            Navigator.of(context).popUntil(
              ModalRoute.withName('/homeView'),
            );
          },
          width: 62,
          height: 44,
          text: Text(
            'done',
            style: Styles.textStyleSemi16.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 135,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 25,
          ),
          child: CustomShield(),
        ),
      ],
    );
  }
}
