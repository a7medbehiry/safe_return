import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_return/core/utils/styles.dart';
import '../../../../homeView/presentation/views/widgets/custom_text_container_with_radius.dart';
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
  bool isTextFieldEnabled = false;

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
    return Scaffold(
      endDrawer: Drawer(
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
              currentAccountPicture: GestureDetector(
                onDoubleTap: () {
                  _pickImageFromGallery();
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
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/profile.svg'),
              title: const Text(
                'My Profile',
                style: Styles.textStyleMed15,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/report.svg'),
              title: const Text(
                'My Reports',
                style: Styles.textStyleMed15,
              ),
              onTap: () {
                GoRouter.of(context).push('/myReportsView');
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/mail.svg'),
              title: const Text(
                'Contact Us',
                style: Styles.textStyleMed15,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset('assets/about.svg'),
              title: const Text(
                'About Us',
                style: Styles.textStyleMed15,
              ),
              onTap: () {
                GoRouter.of(context).push('/aboutUsView');
              },
            ),
            const SizedBox(
              height: 270,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 160),
              child: CustomTextContainerWithRadius(
                width: double.infinity,
                height: 35,
                text: 'Log out',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                ),
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: 180,
                    color: const Color(0xff17586E),
                  ),
                ),
                const Positioned(
                  top: 35,
                  child: CustomProfileAppBar(),
                ),
                Positioned(
                  left: 140,
                  top: 110,
                  child: GestureDetector(
                    onDoubleTap: () {
                      _pickImageFromGallery();
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
                ),
              ],
            ),
            const CustomProfileTextFieldCondition(),
          ],
        ),
      ),
    );
  }
}

StreamController<String> imageChanged = StreamController<String>.broadcast();
