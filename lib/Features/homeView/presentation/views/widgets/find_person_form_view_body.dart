import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_image_picker_function.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
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
          height: 10,
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
            CustomTextFormField(
              onFieldSubmitted: (data) {},
              label: const Text('First Name'),
              width: 160,
              height: 45,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomTextFormField(
              onFieldSubmitted: (data) {},
              label: const Text('Last Name'),
              width: 160,
              height: 45,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          onFieldSubmitted: (data) {},
          keyboardType: TextInputType.phone,
          label: const Text('Phone Number'),
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
          height: 15,
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
          height: 5,
        ),
        const Row(
          children: [
            SizedBox(
              width: 130,
            ),
            Text(
              'Option',
              style: Styles.textStyle12,
            ),
            SizedBox(
              width: 135,
            ),
            Text(
              'Option',
              style: Styles.textStyle12,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              onFieldSubmitted: (data) {},
              label: const Text('Name'),
              width: 160,
              height: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            CustomTextFormField(
              onFieldSubmitted: (data) {},
              keyboardType: TextInputType.number,
              label: const Text('Age'),
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
        CustomTextFormField(
          onFieldSubmitted: (data) {},
          hintText: 'Additional information',
          width: 330,
          height: 110,
          maxLines: 30,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButton(
          onTap: () => context.goNamed('findPersonFormThankYouView'),
          width: 330,
          height: 50,
          text: Text(
            'Confirm',
            style: Styles.textStyleSemi14.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
