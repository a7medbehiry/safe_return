import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';

class CustomSignUpDate extends StatefulWidget {
  const CustomSignUpDate({
    Key? key,
    this.onChanged,
  }) : super(key: key);
  final void Function(DateTime)? onChanged;
  @override
  State<CustomSignUpDate> createState() => _CustomSignUpDateState();
}

class _CustomSignUpDateState extends State<CustomSignUpDate> {
  TextEditingController dateController = TextEditingController();
  DateTime? dob;

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
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
      controller: dateController,
      readOnly: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 110),
        child: SizedBox(
          width: 30,
          child: Center(
            child: SvgPicture.asset(
              'assets/signUpViewPhotos/date.svg',
            ),
          ),
        ),
      ),
      hintText: 'Birth Date',
      width: 330,
      height: 50,
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
          dateController.text = formattedDate;
        },
      );
      if (widget.onChanged != null) {
        widget.onChanged!(pickedDate);
      }
    }
  }
}
