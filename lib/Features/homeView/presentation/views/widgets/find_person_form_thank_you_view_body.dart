import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import 'custom_text_container_with_radius.dart';

class FindPersonFormThankYouViewBody extends StatelessWidget {
  const FindPersonFormThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            'Safe Return',
            style: Styles.textStyle32,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SvgPicture.asset(
          'assets/thankYouPhotos/findPersonFormThankYouView.svg',
          height: 320,
        ),
        const SizedBox(
          height: 30,
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
          onTap: () => context.goNamed('homeView'),
          width: 62,
          height: 44,
          text: Text(
            'done',
            style: Styles.textStyleSemi16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
