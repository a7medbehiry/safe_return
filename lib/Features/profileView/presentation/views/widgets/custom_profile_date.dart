import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/constants.dart';

import '../../../data/models/get_user_model/get_user_model.dart';
import 'custom_profile_text_form_field.dart';

class CustomProfileDate extends StatefulWidget {
  final bool enabled;
  final void Function(DateTime)? onChanged;
  final TextEditingController? controller;
  const CustomProfileDate({
    Key? key,
    this.enabled = false,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomProfileDate> createState() => _CustomProfileDateState();
}

class _CustomProfileDateState extends State<CustomProfileDate> {
  GetUserModel? userModel;
  DateTime? dob;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomProfileTextField(
      onChanged: (data) {
        if (data is DateTime) {
          dob = data as DateTime;
          if (widget.onChanged != null) {
            widget.onChanged!(dob!);
          }
        } else {
          log('Invalid data type for date');
        }
      },
      controller: widget.controller,
      enabled: widget.enabled,
      readOnly: true,
      hintText: 'Data of birth',
      prefixIcon: Center(
        child: SvgPicture.asset(
          'assets/profileViewPhotos/date.svg',
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 36,
      onTap: () {
        customDatePicker();
      },
    );
  }

  Future customDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2080),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kSecondColor,
              onPrimary: kPrimaryColor,
              onSurface: kPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(
        () {
          widget.controller?.text = formattedDate;
        },
      );
      if (widget.onChanged != null) {
        widget.onChanged!(pickedDate);
      }
    }
  }
}
