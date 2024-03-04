import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CheckMailViewBody extends StatelessWidget {
  const CheckMailViewBody({super.key});

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
          inAsyncCall: true,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can\'t get email? ',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
