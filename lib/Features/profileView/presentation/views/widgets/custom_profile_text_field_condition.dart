import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_profile_date.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../manager/user_cubit/user_cubit.dart';
import 'custom_profile_text_form_field.dart';

class CustomProfileTextFieldCondition extends StatefulWidget {
  const CustomProfileTextFieldCondition({
    super.key,
    required this.isImageEnabled,
    required this.onButtonClicked,
  });
  final bool isImageEnabled;
  final VoidCallback onButtonClicked;

  @override
  State<CustomProfileTextFieldCondition> createState() =>
      _CustomProfileTextFieldConditionState();
}

class _CustomProfileTextFieldConditionState
    extends State<CustomProfileTextFieldCondition> {
  bool isTextFieldEnabled = false;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController city = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? name;
  String? phoneNumber;
  String? governorate;
  DateTime? dob;
  String? mail;
  @override
  void initState() {
    userName.text = "";
    email.text = "";
    number.text = "";
    city.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UpdateUserLoading) {
          isLoading = true;
        } else if (state is UpdateUserSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Profile Edited Successfully',
          );
          isLoading = false;
        } else if (state is UpdateUserFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomProfileTextField(
                controller: userName,
                onChanged: (data) {
                  name = data;
                },
                enabled: isTextFieldEnabled,
                hintText: 'User Name',
                prefixIcon: Center(
                  child: SvgPicture.asset(
                    'assets/profileViewPhotos/person.svg',
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 36,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomProfileTextField(
                controller: number,
                onChanged: (data) {
                  phoneNumber = data;
                },
                enabled: isTextFieldEnabled,
                keyboardType: TextInputType.phone,
                hintText: 'Phone Number',
                prefixIcon: Center(
                  child: SvgPicture.asset(
                    'assets/profileViewPhotos/phone.svg',
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 36,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomProfileTextField(
                controller: city,
                onChanged: (data) {
                  governorate = data;
                },
                onSaved: (data) {
                  governorate = data;
                },
                enabled: isTextFieldEnabled,
                hintText: 'Governorate',
                prefixIcon: Center(
                  child: SvgPicture.asset(
                    'assets/profileViewPhotos/location.svg',
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 36,
              ),
              const SizedBox(
                height: 22,
              ),
              CustomProfileDate(
                enabled: isTextFieldEnabled,
                onChanged: (data) {
                  dob = data;
                },
              ),
              const SizedBox(
                height: 22,
              ),
              CustomProfileTextField(
                controller: email,
                onChanged: (data) {
                  mail = data;
                },
                enabled: isTextFieldEnabled,
                hintText:  'Email',
                prefixIcon: Center(
                  child: SvgPicture.asset('assets/profileViewPhotos/mail.svg'),
                ),
                width: MediaQuery.of(context).size.width,
                height: 36,
              ),
              const SizedBox(
                height: 33,
              ),
              CustomButton(
                onTap: () {
                  setState(() {
                    isTextFieldEnabled = !isTextFieldEnabled;
                    widget.onButtonClicked();
                  });
                  if (name == null &&
                      phoneNumber == null &&
                      governorate == null &&
                      dob == null &&
                      mail == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Fields is required',
                    );
                    return;
                  } else if (name == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'User Name is required',
                    );
                    return;
                  } else if (name!.length < 2) {
                    SnackBarManager.showSnackBar(
                      context,
                      'User Name length must be at least 2',
                    );
                    return;
                  } else if (phoneNumber == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Phone Number is required',
                    );
                    return;
                  } else if (phoneNumber!.length < 11) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Phone Number length must be at least 11',
                    );
                    return;
                  } else if (governorate == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Governorate is required',
                    );
                    return;
                  } else if (dob == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Date of birth is required',
                    );
                    return;
                  } else if (mail == null) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Email is required',
                    );
                    return;
                  } else if (EmailValidator.validate(mail!) == false) {
                    SnackBarManager.showSnackBar(
                      context,
                      'In-Valid Email',
                    );
                    return;
                  }
                  BlocProvider.of<UserCubit>(context).updateUser(
                    userName: name!,
                    phoneNumber: phoneNumber!,
                    governorate: governorate!,
                    mail: mail!,
                    dob: dob!,
                  );
                },
                width: 105,
                height: 44,
                text: Text(
                  'Edit Profile',
                  style: Styles.textStyleSemi16.copyWith(
                    color: Colors.white,
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
