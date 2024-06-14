import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_drop_down.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_reports_date.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/custom_text_container_with_radius.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
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
  String? fName;
  String? lName;
  String? phoneNumber;
  String? email;
  String? nId;
  DateTime? dob;
  String? governorate;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is MissingFormLoading) {
          isLoading = true;
        } else if (state is MissingFormSuccess) {
          context.goNamed('missingPersonFormThankYouView');
          isLoading = false;
        } else if (state is MissingFormFailure) {
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
                    height: 20,
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
                    height: 20,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    label: const Text('Email'),
                    prefixIcon: const Icon(
                      Icons.email,
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
                    onChanged: (data) {
                      nId = data;
                    },
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
                        hintText: 'Date',
                        onChanged: (data) {
                          dob = data;
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomDropDown(
                        width: 160,
                        height: 45,
                        onGovernorateSelected: (data) {
                          setState(() {
                            governorate = data;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: 340,
                    height: 50,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (fName == null &&
                            lName == null &&
                            phoneNumber == null &&
                            email == null &&
                            nId == null &&
                            dob == null &&
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
                        } else if (email == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Email Field Required');
                          return;
                        } else if (EmailValidator.validate(email!) == false) {
                          SnackBarManager.showSnackBarForms(
                              context, 'In-Valid Email');
                          return;
                        } else if (nId == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'nationalID Number Field Required');
                          return;
                        } else if (nId!.length < 11) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Invalid National ID Number');
                          return;
                        } else if (dob == null) {
                          SnackBarManager.showSnackBarForms(
                              context, 'Birth Date Field Required');
                          return;
                        }
                      } else if (governorate == null) {
                        SnackBarManager.showSnackBarForms(
                            context, 'Governorate Field Required');
                        return;
                      }
                      BlocProvider.of<FormsCubit>(context).missingForm(
                        fName: fName!,
                        lName: lName!,
                        phoneNumber: phoneNumber!,
                        email: email!,
                        nId: nId!,
                        governorate: governorate!,
                        dob: dob!,
                      );
                    },
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
