import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/profileView/presentation/manager/user_cubit/user_cubit.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_about_us_bottom_sheet.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../data/models/get_user_model/get_user_model.dart';
import '../../../data/models/get_user_model/user.dart';
import 'custom_contact_us_bottom_sheet.dart';
import 'custom_log_out.dart';
import 'custom_profile_app_bar.dart';
import 'custom_profile_text_field_condition.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    Key? key,
  }) : super(key: key);

  @override
  ProfileViewBodyState createState() => ProfileViewBodyState();
}

class ProfileViewBodyState extends State<ProfileViewBody> {
  bool isLoading = false;
  GetUserModel? userModel;

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  late Future<void> initialization;

  File? file;

  Future<void> uploadUserPicture() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null || !mounted) return;

    setState(() {
      file = File(image.path);
    });

    if (mounted) {
      BlocProvider.of<UserCubit>(context).userPicture(
        picture: file!,
      );
    }
  }

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
        if (state is UserPictureLoading) {
          isLoading = true;
        } else if (state is UserPictureSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Profile Picture Changed Successfully',
          );
          isLoading = false;
        } else if (state is UserPictureFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
        if (state is UserLogOutLoading) {
          isLoading = true;
        } else if (state is UserLogOutSuccess) {
          context.goNamed('loginView');
          isLoading = false;
        } else if (state is UserLogOutFailure) {
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
            child: Scaffold(
              endDrawer: customEndDrawer(context),
              body: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 1.6,
                          width: MediaQuery.of(context).size.width,
                        ),
                        ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: 180,
                            color: kPrimaryColor,
                          ),
                        ),
                        const Positioned(
                          top: 35,
                          child: CustomProfileAppBar(),
                        ),
                        customProfilePhoto(),
                      ],
                    ),
                    const CustomProfileTextFieldCondition(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox customEndDrawer(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  userModel?.user?.userName ?? 'User Name',
                  style: Styles.textStyleSemi16.copyWith(
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  userModel?.user?.email ?? 'Email',
                  style: Styles.textStyle12.copyWith(
                    color: const Color(0xff9C9C9C),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  child: Stack(
                    children: [
                      if (userModel?.user?.profilePic?.secureUrl != null)
                        Positioned.fill(
                          child: ClipOval(
                            child: Image.network(
                              userModel!.user!.profilePic!.secureUrl!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      if (file != null)
                        Positioned.fill(
                          child: ClipOval(
                            child: Image.file(
                              (file!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      if (file == null &&
                          userModel?.user?.profilePic?.secureUrl == null)
                        const Positioned.fill(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/profileEndDrawerPhotos/profile.svg',
                ),
                title: const Text(
                  'My Profile',
                  style: Styles.textStyleMed15,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/profileEndDrawerPhotos/report.svg',
                ),
                title: const Text(
                  'My Missing Reports',
                  style: Styles.textStyleMed15,
                ),
                onTap: () => context.goNamed('myMissingReportsView'),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/profileEndDrawerPhotos/report.svg',
                ),
                title: const Text(
                  'My Find Reports',
                  style: Styles.textStyleMed15,
                ),
                onTap: () => context.goNamed('myFindReportsView'),
              ),
              ListTile(
                leading:
                    SvgPicture.asset('assets/profileEndDrawerPhotos/mail.svg'),
                title: const Text(
                  'Contact Us',
                  style: Styles.textStyleMed15,
                ),
                onTap: () => customContactUsBottomSheet(context),
              ),
              ListTile(
                leading:
                    SvgPicture.asset('assets/profileEndDrawerPhotos/about.svg'),
                title: const Text(
                  'About Us',
                  style: Styles.textStyleMed15,
                ),
                onTap: () => customAboutUsBottomSheet(context),
              ),
              const SizedBox(
                height: 190,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 100),
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove('email');
                    BlocProvider.of<UserCubit>(context).userLogOut();
                  },
                  child: const CustomLogOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned customProfilePhoto() {
    return Positioned(
      left: 140,
      top: 110,
      child: GestureDetector(
        onLongPress: () {
          uploadUserPicture();
        },
        child: CircleAvatar(
          radius: 60,
          child: Stack(
            children: [
              if (userModel?.user?.profilePic?.secureUrl != null)
                Positioned.fill(
                  child: ClipOval(
                    child: Image.network(
                      userModel!.user!.profilePic!.secureUrl!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (file != null)
                Positioned.fill(
                  child: ClipOval(
                    child: Image.file(
                      (file!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (file == null &&
                  userModel?.user?.profilePic?.secureUrl == null)
                const Positioned.fill(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
