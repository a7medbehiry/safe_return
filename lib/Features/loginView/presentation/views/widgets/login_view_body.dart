import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/loginView/manager/login_cubit/login_cubit.dart';
import 'package:safe_return/constants.dart';
import 'custom_bottom_part.dart';
import 'custom_top_part.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return SizedBox(
          width: double.infinity,
          height: 900,
          child: ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
            inAsyncCall: isLoading,
            child: const Column(
              children: [
                CustomTopPart(),
                CustomBottomPart(),
              ],
            ),
          ),
        );
      },
    );
  }
}
