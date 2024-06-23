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

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          isLoading = true;
        } else if (state is ResetPasswordSuccess) {
          context.goNamed('loginView');
          SnackBarManager.showSnackBar(context, 'Reset Password Success');
          isLoading = false;
        } else if (state is ResetPasswordFailure) {
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
                      height: 90,
                    ),
                    Text(
                      'Change New Password',
                      style: Styles.textStyleBlack17.copyWith(
                        color: const Color(0xff374151),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Enter your registered email below',
                      style: Styles.textStyleSemi15.copyWith(
                        color: const Color(0xff9CA3AF),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'New Password',
                        style: Styles.textStyleSemi15.copyWith(
                          color: const Color(0xff9CA3AF),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
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
                      fillColor: const Color(0xffFFFBFE),
                      label: const Text('Password'),
                      width: 335,
                      height: 85,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Confirm Password',
                        style: Styles.textStyleSemi15.copyWith(
                          color: const Color(0xff9CA3AF),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextFormField(
                      onChanged: (data) {
                        confirmPassword = data;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Field is required';
                        } else {
                          return null;
                        }
                      },
                      fillColor: const Color(0xffFFFBFE),
                      label: const Text('Confirm Password'),
                      width: 335,
                      height: 85,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SvgPicture.asset(
                          'assets/resetPasswordPhotos/resetPassword.svg'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (password!.length < 5) {
                              SnackBarManager.showSnackBar(context,
                                  'Password length must be at least 5');
                              return;
                            } else if (confirmPassword != password) {
                              SnackBarManager.showSnackBar(context,
                                  'Confirm Password must match Password');
                              return;
                            }
                            BlocProvider.of<AuthCubit>(context)
                                .userResetPassword(
                              password: password!,
                              confirmPassword: confirmPassword!,
                            );
                          }
                        },
                        width: 256,
                        height: 53,
                        text: Text(
                          'Reset Password',
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
