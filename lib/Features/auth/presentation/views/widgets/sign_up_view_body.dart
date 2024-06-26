import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_shield.dart';
import '../../manager/auth_cubit/auth_cubit.dart';
import 'custom_animated_container_activation.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          context.goNamed('loginView');
          SnackBarManager.showSnackBar(context, 'Please, verify your email');
          isLoading = false;
        } else if (state is SignUpFailure) {
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
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.65,
                      ),
                      Positioned(
                        left: -100,
                        top: -60,
                        child: SvgPicture.asset(
                          'assets/signUpViewPhotos/shape.svg',
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 60,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            'assets/signUpViewPhotos/arrow.svg',
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 150,
                        top: 60,
                        child: Text(
                          'New Account',
                          style: Styles.textStyleBlack17,
                        ),
                      ),
                      Positioned(
                        left: 33,
                        top: 150,
                        child: Row(
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
                      ),
                    ],
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
                        if (fName == null &&
                            lName == null &&
                            dob == null &&
                            gender == null &&
                            email == null &&
                            password == null &&
                            confirmPassword == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Fields Required');
                          return;
                        } else if (fName == null) {
                          SnackBarManager.showSnackBar(
                              context, 'First Name Field Required');
                          return;
                        } else if (fName!.length < 2) {
                          SnackBarManager.showSnackBar(
                              context, 'First Name length must be at least 2');
                          return;
                        } else if (lName == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Last Name Field Required');
                          return;
                        } else if (lName!.length < 2) {
                          SnackBarManager.showSnackBar(
                              context, 'Last Name length must be at least 2');
                          return;
                        } else if (dob == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Birth Date Field Required');
                          return;
                        } else if (gender == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Gender is required');
                          return;
                        } else if (email == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Email Field Required');
                          return;
                        } else if (EmailValidator.validate(email!) == false) {
                          SnackBarManager.showSnackBar(
                              context, 'In-Valid Email');
                          return;
                        } else if (password == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Password Field Required');
                          return;
                        } else if (password!.length < 5) {
                          SnackBarManager.showSnackBar(
                              context, 'Password length must be at least 5');
                          return;
                        } else if (confirmPassword == null) {
                          SnackBarManager.showSnackBar(
                              context, 'Confirm Password Field Required');
                          return;
                        } else if (confirmPassword != password) {
                          SnackBarManager.showSnackBar(
                              context, 'Confirm Password must match Password');
                          return;
                        }

                        BlocProvider.of<AuthCubit>(context).userSignUp(
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
                    height: 80,
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
