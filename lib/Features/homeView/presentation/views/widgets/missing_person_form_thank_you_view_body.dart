import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import 'custom_text_container_with_radius.dart';

class MissingPersonFormThankYouViewBody extends StatelessWidget {
  const MissingPersonFormThankYouViewBody({super.key});

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
          image: AssetImage(
              'assets/thankYouPhotos/missingPersonFormThankYouView.gif'),
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
          'Now we will do our best for your son\'s return',
          style: Styles.textStyleReg14,
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          onTap: () => context.goNamed('homeView'),
          width: 62,
          height: 44,
          text: Text(
            'done',
            style: Styles.textStyleSemi16.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
