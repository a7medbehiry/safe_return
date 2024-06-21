import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';

class CheckMailViewBody extends StatefulWidget {
  const CheckMailViewBody({super.key});

  @override
  State<CheckMailViewBody> createState() => _CheckMailViewBodyState();
}

class _CheckMailViewBodyState extends State<CheckMailViewBody> {
  bool isLoading = false;
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GestureDetector(
        onDoubleTap: () => context.goNamed('resetPassword'),
        child: ModalProgressHUD(
          progressIndicator: const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ),
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child:
                      SvgPicture.asset('assets/checkMailPhotos/checkMail.svg'),
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
                  'Please check your email for create',
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
                  numberOfFields: 5,
                  enabledBorderColor: kSecondColor,
                  focusedBorderColor: kPrimaryColor,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                    otpCode = code;
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
                  onTap: () async {},
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
  }
}
