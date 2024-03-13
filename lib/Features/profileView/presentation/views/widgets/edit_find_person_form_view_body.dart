import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import '../../../../homeView/presentation/views/widgets/custom_image_picker_function.dart';
import '../../../../homeView/presentation/views/widgets/custom_reports_date.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container_with_radius.dart';

class EditFindPersonFormViewBody extends StatefulWidget {
  const EditFindPersonFormViewBody({super.key});

  @override
  State<EditFindPersonFormViewBody> createState() =>
      _EditFindPersonFormViewBodyState();
}

class _EditFindPersonFormViewBodyState
    extends State<EditFindPersonFormViewBody> {
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
                height: 15,
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
                    onChanged: (data) {},
                    label: const Text('Name'),
                    width: 160,
                    height: 45,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomReportsDate(
                    onChanged: (data) {},
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const CustomImagePickerFunction(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomDropDown(
                width: 330,
                height: 45,
                onGovernorateSelected: (data) {},
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
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
                  context.goNamed('myReportsView');
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
            ],
          ),
        ),
      ),
    );
  }
}
