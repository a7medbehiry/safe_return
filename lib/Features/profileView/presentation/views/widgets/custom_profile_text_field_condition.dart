import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/Features/profileView/data/models/get_user_model/get_user_model.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_profile_date.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../data/models/get_user_model/user.dart';
import '../../manager/user_cubit/user_cubit.dart';
import 'custom_profile_text_form_field.dart';

class CustomProfileTextFieldCondition extends StatefulWidget {
  const CustomProfileTextFieldCondition({
    super.key,
  });

  @override
  State<CustomProfileTextFieldCondition> createState() =>
      _CustomProfileTextFieldConditionState();
}

class _CustomProfileTextFieldConditionState
    extends State<CustomProfileTextFieldCondition> {
  bool isTextFieldEnabled = false;
  TextEditingController userName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController date = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  GetUserModel? userModel;
  bool isLoading = false;
  String? name;
  String? phoneNumber;
  String? governorate;
  DateTime? dob;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    userModel = GetUserModel(message: 'initial message', user: User());
    await BlocProvider.of<UserCubit>(context).getUser(
      userModel!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserLoading) {
          isLoading = true;
        } else if (state is GetUserSuccess) {
          userModel = GetUserModel(message: 'success', user: state.user);
          userName.text = userModel?.user?.userName ?? '';
          number.text = userModel?.user?.phoneNumber ?? '';
          city.text = userModel?.user?.governorate ?? '';
          date.text = userModel?.user?.dob != null
              ? DateFormat('yyyy-MM-dd').format(userModel!.user!.dob!)
              : '';
          email.text = userModel?.user?.email ?? '';
          isLoading = false;
        } else if (state is GetUserFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
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
                hintText: userModel?.user?.userName ?? 'User Name',
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
                hintText: userModel?.user?.phoneNumber ?? 'Phone Number',
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
                enabled: isTextFieldEnabled,
                hintText: userModel?.user?.governorate ?? 'Governorate',
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
                controller: date,
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
                enabled: false,
                hintText: userModel?.user?.email ?? 'Email',
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
                    if (formKey.currentState!.validate()) {
                      isTextFieldEnabled = !isTextFieldEnabled;
                    }
                  });
                  if (userName.text.length < 2) {
                    SnackBarManager.showSnackBar(
                      context,
                      'User Name length must be at least 2',
                    );
                    isTextFieldEnabled = true;
                    return;
                  } else if (number.text.length < 11) {
                    SnackBarManager.showSnackBar(
                      context,
                      'Phone Number length must be at least 11',
                    );
                    isTextFieldEnabled = true;
                    return;
                  } else if (isTextFieldEnabled == false) {
                    BlocProvider.of<UserCubit>(context).updateUser(
                      userName: userName.text,
                      phoneNumber: number.text,
                      governorate: city.text,
                      dob: DateTime.parse(date.text),
                    );
                  }
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
