import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_edit_find_form_image_picker.dart';

class CustomEditFindFormImagePickerFunction extends StatefulWidget {
  final Function(File)? onImageSelected;
  final String? src;
  const CustomEditFindFormImagePickerFunction(
      {super.key, this.onImageSelected, this.src});

  @override
  State<CustomEditFindFormImagePickerFunction> createState() =>
      _CustomEditFindFormImagePickerFunctionState();
}

class _CustomEditFindFormImagePickerFunctionState
    extends State<CustomEditFindFormImagePickerFunction> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImageFromGallery();
        if (_image == null) return;
        widget.onImageSelected!(_image!);
      },
      child: CustomEditFindFormImagePicker(
        image: _image,
        src: widget.src,
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
