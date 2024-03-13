import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_image_picker_function.dart';
import 'package:safe_return/constants.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import 'custom_drop_down.dart';
import 'custom_reports_date.dart';
import 'custom_text_container.dart';
import 'custom_text_container_with_radius.dart';

class FindPersonFormViewBody extends StatefulWidget {
  const FindPersonFormViewBody({super.key});

  @override
  State<FindPersonFormViewBody> createState() => _FindPersonFormViewBodyState();
}

class _FindPersonFormViewBodyState extends State<FindPersonFormViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  File? image;
  String? fName;
  String? lName;
  String? phoneNumber;
  String? name;
  int? age;
  DateTime? dob;
  String? governorate;
  String? description;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is FindFormLoading) {
          isLoading = true;
        } else if (state is FindFormSuccess) {
          context.goNamed('findPersonFormThankYouView');
          SnackBarManager.showSnackBar(
            context,
            'Form is Confirmed Successfully',
          );
          isLoading = false;
        } else if (state is FindFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
                context, errorMessage['message'].toString());
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                        onChanged: (data) {
                          fName = data;
                        },
                        label: const Text('First Name'),
                        width: 160,
                        height: 45,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          lName = data;
                        },
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
                    onChanged: (data) {
                      phoneNumber = data;
                    },
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
                        onChanged: (data) {
                          name = data;
                        },
                        label: const Text('Name'),
                        width: 160,
                        height: 45,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomTextFormField(
                        onChanged: (data) {
                          age = int.parse(data);
                        },
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
                        onChanged: (data) {
                          dob = data;
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomImagePickerFunction(
                        onImageSelected: (data) {
                          setState(() {
                            image = data;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropDown(
                    width: 330,
                    height: 45,
                    onGovernorateSelected: (data) {
                      setState(() {
                        governorate = data;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      description = data;
                    },
                    hintText: 'Additional information',
                    width: 330,
                    height: 110,
                    maxLines: 30,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (fName == null &&
                            lName == null &&
                            phoneNumber == null &&
                            dob == null &&
                            image == null &&
                            governorate == null) {
                          SnackBarManager.showSnackBarForms(
                            context,
                            'Fields Required',
                          );
                          return;
                        } else if (fName == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'First Name Field Required');
                          return;
                        } else if (fName!.length < 2) {
                          SnackBarManager.showSnackBarForms(
                              context, 'First Name length must be at least 2');
                          return;
                        } else if (lName == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Last Name Field Required');
                          return;
                        } else if (lName!.length < 2) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Last Name length must be at least 2');
                          return;
                        } else if (phoneNumber == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Phone Number Field Required');
                          return;
                        } else if (phoneNumber!.length < 11) {
                          SnackBarManager.showSnackBarForms(
                              context, 'In-Valid Phone Number');
                          return;
                        } else if (dob == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Birth Date Field Required');
                          return;
                        } else if (image == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Image Field Required');
                          return;
                        } else if (governorate == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Governorate Field Required');
                          return;
                        }
                        BlocProvider.of<FormsCubit>(context).findForm(
                          image: image!,
                          fName: fName!,
                          lName: lName!,
                          phoneNumber: phoneNumber!,
                          name: name!,
                          age: age!,
                          dob: dob!,
                          governorate: governorate!,
                          description: description,
                        );
                      }
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
      },
    );
  }
}
