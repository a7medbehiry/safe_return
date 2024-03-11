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
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';

import '../../manager/auth_cubit/auth_cubit.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  String? email;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          isLoading = true;
        } else if (state is ForgetPasswordSuccess) {
          context.goNamed('checkMail');
          isLoading = false;
        } else if (state is ForgetPasswordFailure) {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: SvgPicture.asset(
                          'assets/forgetPasswordPhotos/forgetPassword.svg'),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    const Text(
                      'Forget Password',
                      style: Styles.textStyleSemi16,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Enter your registered email below',
                      style: Styles.textStyleMed15.copyWith(
                        color: const Color(0xff9CA3AF),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Email address',
                        style: Styles.textStyleSemi16.copyWith(
                          color: const Color(0xff9CA3AF),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
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
                      fillColor: const Color(0xffFFFBFE),
                      label: const Text('Email'),
                      width: 335,
                      height: 85,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Remember the password? ',
                          style: Styles.textStyleMed15.copyWith(
                            color: const Color(0xff9CA3AF),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Log In',
                            style: Styles.textStyleSemi15.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (EmailValidator.validate(email!) == false) {
                              SnackBarManager.showSnackBar(
                                  context, 'In-Valid Email');
                              return;
                            }
                            BlocProvider.of<AuthCubit>(context)
                                .userForgetPassword(
                              email: email!,
                            );
                          }
                        },
                        width: 256,
                        height: 53,
                        text: Text(
                          'Submit',
                          style: Styles.textStyleBold14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
