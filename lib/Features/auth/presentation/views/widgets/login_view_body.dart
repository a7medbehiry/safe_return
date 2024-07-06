import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import 'package:safe_return/core/utils/widgets/custom_shield.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../manager/auth_cubit/auth_cubit.dart';
import '../../manager/auth_cubit/firebase_service.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();

  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          context.goNamed('homeView');
          isLoading = false;
        } else if (state is LoginFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
                context, errorMessage['message'].toString());
          }
          isLoading = false;
        }

        if (state is GoogleLoginLoading) {
          isLoading = true;
        } else if (state is GoogleLoginSuccess) {
          context.goNamed('homeView');

          isLoading = false;
        } else if (state is GoogleLoginFailure) {
          SnackBarManager.showSnackBar(
              context, 'Email is found in application database, please Login');
          isLoading = false;
        }

        if (state is FaceBookLoginLoading) {
          isLoading = true;
        } else if (state is FaceBookLoginSuccess) {
          context.goNamed('homeView');

          isLoading = false;
        } else if (state is FaceBookLoginFailure) {
          SnackBarManager.showSnackBar(
              context, 'Email is found in application database, please Login');
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
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Positioned(
                    left: -100,
                    top: -60,
                    child: SvgPicture.asset(
                      'assets/loginViewPhotos/shape.svg',
                    ),
                  ),
                  Positioned(
                    right: -100,
                    bottom: -100,
                    child: SvgPicture.asset(
                        'assets/loginViewPhotos/shapeReverse.svg'),
                  ),
                  const Positioned(
                    left: 105,
                    top: 55,
                    child: Text(
                      'Safe Return',
                      style: Styles.textStyle32,
                    ),
                  ),
                  Positioned(
                    left: 120,
                    top: 120,
                    child: SvgPicture.asset(
                      'assets/loginViewPhotos/loginView.svg',
                    ),
                  ),
                  const Positioned(
                    left: 25,
                    top: 305,
                    child: Text(
                      'Welcome!',
                      style: Styles.textStyleBlack17,
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 345,
                    child: CustomTextFormField(
                      controller: emailController,
                      onChanged: (data) {
                        email = data;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Field is required';
                        } else {
                          return null;
                        }
                      },
                      fillColor: const Color(0xffF3F6F6),
                      width: 350,
                      height: 85,
                      label: const Text('Email'),
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 430,
                    child: CustomTextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Field is required';
                        } else {
                          return null;
                        }
                      },
                      fillColor: const Color(0xffF3F6F6),
                      width: 350,
                      height: 85,
                      label: const Text('Password'),
                      obscureText: true,
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 485,
                    child: GestureDetector(
                      onTap: () => GoRouter.of(context).push('/forgetPassword'),
                      child: Text(
                        'Forget Password',
                        style: Styles.textStyle12.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 150,
                    top: 510,
                    child: CustomButton(
                      onTap: () async {
                        // Obtain shared preferences and store the email
                        final SharedPreferences preferences =
                            await SharedPreferences.getInstance();

                        // Check if emailController.text is not empty
                        if (emailController.text.isNotEmpty) {
                          preferences.setString('email', emailController.text);
                        } else {
                          // Remove the 'email' key if emailController.text is empty
                          preferences.remove('email');
                        }
                        // Validate the form and email
                        if (formKey.currentState!.validate()) {
                          if (!EmailValidator.validate(email!)) {
                            if (!context.mounted) {
                              return; // Check if the context is still valid
                            }
                            SnackBarManager.showSnackBar(
                                context, 'Invalid Email');
                            return;
                          }

                          // Check if the context is still valid before proceeding
                          if (!context.mounted) {
                            return;
                          }

                          // Perform the login operation
                          BlocProvider.of<AuthCubit>(context).userLogin(
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                      width: 96,
                      height: 40,
                      text: Text(
                        'Log In',
                        style: Styles.textStyleReg16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 133,
                    bottom: 220,
                    child: Text(
                      'Or Continue With',
                      style: Styles.textStyleMed15
                          .copyWith(color: Colors.black.withOpacity(.6)),
                    ),
                  ),
                  Positioned(
                    left: 110,
                    bottom: 150,
                    child: GestureDetector(
                      onTap: () async {
                        await FirebaseFaceBookServiceLogin()
                            .signInWithFacebook(context);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/loginViewPhotos/facebook.svg',
                          ),
                          const Text(
                            'Facebook',
                            style: Styles.textStyleReg14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 110,
                    bottom: 150,
                    child: GestureDetector(
                      onTap: () async {
                        FirebaseGoogleServiceLogin().signInWithGoogle(context);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/loginViewPhotos/google.svg',
                          ),
                          const Text(
                            'Google',
                            style: Styles.textStyleReg14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 100,
                    bottom: 110,
                    child: Text(
                      'Don\'t have an account ?',
                      style: Styles.textStyleReg16,
                    ),
                  ),
                  Positioned(
                    left: 165,
                    bottom: 60,
                    child: CustomButton(
                      onTap: () => GoRouter.of(context).push('/signUpView'),
                      color: kSecondColor,
                      width: 64,
                      height: 38,
                      text: Text(
                        'Sign Up',
                        style: Styles.textStyle12.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 30,
                    bottom: 15,
                    child: CustomShield(),
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
