import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';

class CheckMailViewBody extends StatefulWidget {
  const CheckMailViewBody({super.key});

  @override
  State<CheckMailViewBody> createState() => _CheckMailViewBodyState();
}

class _CheckMailViewBodyState extends State<CheckMailViewBody> {
  bool isLoading = false;
  String? resetCode;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        setState(() {
          if (state is CheckMailLoading) {
            isLoading = true;
          } else if (state is CheckMailSuccess) {
            context.goNamed('resetPassword');
            isLoading = false;
            resetCode = null; // Clear the resetCode after success
          } else if (state is CheckMailFailure) {
            for (var errorMessage in state.errorMessages) {
              SnackBarManager.showSnackBar(
                  context, errorMessage['message'].toString());
            }
            isLoading = false;
          }
        });
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: SvgPicture.asset(
                          'assets/checkMailPhotos/checkMail.svg'),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Success',
                      style: Styles.textStyle24.copyWith(
                        color: const Color(0xff374151),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Please check your email to create',
                      style: Styles.textStyleMed15.copyWith(
                        color: const Color(0xff9CA3AF),
                      ),
                    ),
                    Text(
                      'a new password',
                      style: Styles.textStyleMed15.copyWith(
                        color: const Color(0xff9CA3AF),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    OtpTextField(
                      numberOfFields: 4,
                      enabledBorderColor: kSecondColor,
                      focusedBorderColor: kPrimaryColor,
                      showFieldAsBox: true,
                      onSubmit: (String code) {
                        setState(() {
                          resetCode = code;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Can\'t get OTP? ',
                          style: Styles.textStyleSemi15.copyWith(
                            color: const Color(0xff9CA3AF),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            'Resubmit',
                            style: Styles.textStyleSemi16.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                      width: 340,
                      height: 50,
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          if (resetCode != null && resetCode!.length == 4) {
                            BlocProvider.of<AuthCubit>(context).checkMail(
                              resetCode: resetCode!,
                            );
                          } else {
                            SnackBarManager.showSnackBar(
                                context, "Please enter a valid OTP code");
                          }
                        }
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
          ),
        );
      },
    );
  }
}
