import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_image_picker.dart';

class CustomImagePickerFunction extends StatefulWidget {
  const CustomImagePickerFunction({super.key});

  @override
  State<CustomImagePickerFunction> createState() =>
      _CustomImagePickerFunctionState();
}

class _CustomImagePickerFunctionState extends State<CustomImagePickerFunction> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImageFromGallery();
      },
      child: CustomImagePicker(
        image: _image,
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
  }
}
