import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/signUpView/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:safe_return/Features/signUpView/presentation/views/widgets/custom_animated_container_activation.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/helper/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import 'custom_sign_up_date.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  String? fName;
  String? lName;
  String? email;
  String? password;
  String? confirmPassword;
  DateTime? dob;
  Gender? gender;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          context.goNamed('loginView');
          SnackBarManager.showSnackBar(context, 'Please, verify your email');
          isLoading = false;
        } else if (state is SignUpFailure) {
          SnackBarManager.showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 800,
          child: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            inAsyncCall: isLoading,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
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
                    height: 24,
                  ),
                  CustomSignUpDate(
                    onChanged: (data) {
                      dob = data;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CustomAnimatedContainerActivation(
                      onGenderSelected: (selectedGender) {
                        setState(() => gender = selectedGender);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      email = data;
                    },
                    label: const Text('Email'),
                    width: 330,
                    height: 45,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      password = data;
                    },
                    obscureText: true,
                    label: const Text('Password'),
                    width: 330,
                    height: 45,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      confirmPassword = data;
                    },
                    obscureText: true,
                    label: const Text('Confirm Password'),
                    width: 330,
                    height: 45,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (fName!.length < 2) {
                          SnackBarManager.showSnackBar(
                              context, 'First Name length must be at least 2');
                          return;
                        } else if (lName!.length < 2) {
                          SnackBarManager.showSnackBar(
                              context, 'Last Name length must be at least 2');
                          return;
                        } else if (gender == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Gender is required');
                          return;
                        } else if (EmailValidator.validate(email!) == false) {
                          SnackBarManager.showSnackBar(
                              context, 'In-Valid Email');
                          return;
                        } else if (password!.length < 5) {
                          SnackBarManager.showSnackBar(
                              context, 'Password length must be at least 5');
                          return;
                        } else if (confirmPassword != password) {
                          SnackBarManager.showSnackBar(
                              context, 'Confirm Password must match Password');
                          return;
                        }

                        BlocProvider.of<SignUpCubit>(context).userSignUp(
                          fName: fName!,
                          lName: lName!,
                          email: email!,
                          password: password!,
                          confirmPassword: confirmPassword!,
                          dob: dob!,
                          gender: gender!,
                        );
                      }
                    },
                    width: 330,
                    height: 45,
                    text: Text(
                      'Create account',
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
                        style: Styles.textStyleSemi14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: CustomShield(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
