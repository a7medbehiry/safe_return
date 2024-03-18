import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';

class CustomEditFindFormImagePicker extends StatelessWidget {
  const CustomEditFindFormImagePicker({
    super.key,
    required File? image,
    this.src,
  }) : _image = image;

  final File? _image;
  final String? src;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            if (_image != null)
              Container(
                width: 160,
                height: 45,
                decoration: ShapeDecoration(
                  color: kThirdColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/FormsViewPhotos/camera.svg',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Photo',
                      style: Styles.textStyleReg16,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                        radius: 15,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipOval(
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            if (_image == null)
              Container(
                width: 160,
                height: 45,
                decoration: ShapeDecoration(
                  color: kThirdColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/FormsViewPhotos/camera.svg',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Photo',
                      style: Styles.textStyleReg16,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    if (src != null)
                      CircleAvatar(
                        radius: 15,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipOval(
                                child: Image.network(
                                  src!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
