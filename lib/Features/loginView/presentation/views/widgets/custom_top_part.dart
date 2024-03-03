import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/loginView/manager/login_cubit/login_cubit.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/styles.dart';

class CustomTopPart extends StatefulWidget {
  const CustomTopPart({
    super.key,
  });

  @override
  State<CustomTopPart> createState() => _CustomTopPartState();
}

class _CustomTopPartState extends State<CustomTopPart> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          context.goNamed('homeView');
          isLoading = false;
        } else if (state is LoginFailure) {
          for (var errorMessage in state.errorMessages) {
            LoginSnackBarManager.showSnackBar(
                context, errorMessage['message'].toString());
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 460,
              ),
              Positioned(
                top: 40,
                child: SvgPicture.asset(
                  'assets/loginViewPhotos/rect3.svg',
                ),
              ),
              Positioned(
                left: -2,
                child: SvgPicture.asset(
                  'assets/loginViewPhotos/rect2.svg',
                ),
              ),
              Positioned(
                child: SvgPicture.asset(
                  'assets/loginViewPhotos/rect1.svg',
                ),
              ),
              Positioned(
                left: 105,
                top: 45,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: .1,
                    sigmaY: .1,
                  ),
                  child: Text(
                    'Safe Return',
                    style: Styles.textStyle32.copyWith(
                      color: Colors.white.withOpacity(.85),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 190,
                child: Text(
                  'Welcome!',
                  style: Styles.textStyleSemi16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 230,
                child: CustomTextFormField(
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
                top: 315,
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
                right: 25,
                top: 370,
                child: GestureDetector(
                  onTap: () {},
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
                top: 420,
                child: CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (EmailValidator.validate(email!) == false) {
                        LoginSnackBarManager.showSnackBar(context, 'In-Valid Email');
                        return;
                      }
                      BlocProvider.of<LoginCubit>(context).userLogin(
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
            ],
          ),
        );
      },
    );
  }
}
