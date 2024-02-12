import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_reports_date.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container_with_radius.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';

class MissingPersonFormViewBody extends StatelessWidget {
  const MissingPersonFormViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
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
          height: 30,
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
          height: 20,
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
          height: 25,
        ),
        CustomTextContainer(
          width: 330,
          height: 50,
          text: 'Information about the missing person',
          style: Styles.textStyleLight16.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        CustomTextField(
           onChanged: (data) {},
          keyboardType: TextInputType.number,
          hintText: 'National Id ',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/FormsViewPhotos/id.svg',
            ),
          ),
          width: 330,
          height: 50,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomReportsDate(),
            SizedBox(
              width: 15,
            ),
            CustomDropDown(
              width: 160,
              height: 45,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          onTap: () {},
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
          height: 135,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: CustomShield(),
        )
      ],
    );
  }
}
