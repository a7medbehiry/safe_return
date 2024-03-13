import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_reports_date.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container_with_radius.dart';
import 'package:safe_return/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class MissingPersonFormViewBody extends StatefulWidget {
  const MissingPersonFormViewBody({super.key});

  @override
  State<MissingPersonFormViewBody> createState() =>
      _MissingPersonFormViewBodyState();
}

class _MissingPersonFormViewBodyState extends State<MissingPersonFormViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ModalProgressHUD(
        progressIndicator: const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Column(
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
                  CustomTextFormField(
                    onChanged: (data) {},
                    label: const Text('First Name'),
                    width: 160,
                    height: 45,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {},
                    label: const Text('Last Name'),
                    width: 160,
                    height: 45,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                onChanged: (data) {},
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
              CustomTextFormField(
                onChanged: (data) {},
                keyboardType: TextInputType.number,
                label: const Text('National ID'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomReportsDate(
                    onChanged: (data) {},
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomDropDown(
                    width: 160,
                    height: 45,
                    onGovernorateSelected: (data) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () => context.goNamed('missingPersonFormThankYouView'),
                width: 340,
                height: 50,
                text: Text(
                  'Confirm',
                  style: Styles.textStyleSemi14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
