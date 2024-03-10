import 'dart:async';
import 'dart:convert';
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
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import 'custom_contact_us_bottom_sheet.dart';
import 'custom_log_out.dart';
import 'custom_profile_app_bar.dart';
import 'custom_profile_text_field_condition.dart';

class ProfileViewBody extends StatefulWidget {
  final String? _image;

  const ProfileViewBody({
    Key? key,
    String? imageString,
  })  : _image = imageString,
        super(key: key);

  @override
  ProfileViewBodyState createState() => ProfileViewBodyState();
}

class ProfileViewBodyState extends State<ProfileViewBody> {
  String? _image;
  bool isImageEnabled = false;
  bool isLoading = false;
  void toggleImageEnabled() {
    setState(() {
      isImageEnabled = !isImageEnabled;
    });
  }

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    final base64Image = base64Encode(imageBytes);
    setState(() {
      _image = base64Image;
      imageChanged.add(_image as String);
    });
  }

  @override
  void initState() {
    super.initState();
    _image = widget._image;
    listenForStream();
  }

  void listenForStream() {
    imageChanged.stream.listen((onData) {
      setState(() {
        _image = onData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
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
                    CustomProfileTextFieldCondition(
                      isImageEnabled: isImageEnabled,
                      onButtonClicked: toggleImageEnabled,
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
                  'Ahmed Behiry',
                  style: Styles.textStyleSemi16.copyWith(
                    color: Colors.black,
                  ),
                ),
                accountEmail: Text(
                  'amb@gmail.com',
                  style: Styles.textStyle12.copyWith(
                    color: const Color(0xff9C9C9C),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  child: Stack(
                    children: [
                      if (_image != null)
                        Positioned.fill(
                          child: ClipOval(
                            child: Image.memory(
                              base64Decode(_image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      if (_image == null)
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
                  'My Reports',
                  style: Styles.textStyleMed15,
                ),
                onTap: () => context.goNamed('myReportsView'),
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
                height: 240,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 100),
                child: GestureDetector(
                  onTap: () async {
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
        onTap: () {
          if (isImageEnabled) {
            _pickImageFromGallery();
          }
        },
        child: CircleAvatar(
          radius: 60,
          child: Stack(
            children: [
              if (_image != null)
                Positioned.fill(
                  child: ClipOval(
                    child: Image.memory(
                      base64Decode(_image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              if (_image == null)
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

StreamController<String> imageChanged = StreamController<String>.broadcast();
