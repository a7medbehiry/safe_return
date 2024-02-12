import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_image_picker_function.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import 'custom_drop_down.dart';
import 'custom_reports_date.dart';
import 'custom_text_container.dart';
import 'custom_text_container_with_radius.dart';

class FindPersonFormViewBody extends StatelessWidget {
  const FindPersonFormViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        CustomTextContainerWithRadius(
          width: 160,
          height: 40,
          text: 'personal',
          style: Styles.textStyleLight16.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
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
          height: 15,
        ),
        CustomTextField(
          onChanged: (data) {},
          keyboardType: TextInputType.phone,
          hintText: 'phone number',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/FormsViewPhotos/phone.svg',
            ),
          ),
          width: 330,
          height: 45,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextContainer(
          width: 330,
          height: 50,
          text: 'Information about the  person you found',
          style: Styles.textStyleLight14.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              onChanged: (data) {},
              hintText: 'Name',
              width: 160,
              height: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            CustomTextField(
              onChanged: (data) {},
              keyboardType: TextInputType.number,
              hintText: 'Age',
              width: 160,
              height: 45,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomReportsDate(),
            SizedBox(
              width: 15,
            ),
            CustomImagePickerFunction(),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomDropDown(
          width: 330,
          height: 45,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          onChanged: (data) {},
          hintText: 'Additional information',
          width: 330,
          height: 110,
          maxLines: 30,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButton(
          onTap: () {
            GoRouter.of(context).push('/findPersonFormThankYouView');
          },
          width: 330,
          height: 50,
          text: Text(
            'Confirm',
            style: Styles.textStyleSemi14.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
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
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: CustomShield(),
        )
      ],
    );
  }
}
