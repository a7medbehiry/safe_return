import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/widgets/custom_text_form_field.dart';

class CustomReportsDate extends StatefulWidget {
  final void Function(DateTime)? onChanged;
  final String? hintText;
  const CustomReportsDate({
    Key? key,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomReportsDate> createState() => _CustomReportsDateState();
}

class _CustomReportsDateState extends State<CustomReportsDate> {
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
      prefixIcon: SizedBox(
        width: 30,
        child: Center(
          child: SvgPicture.asset(
            'assets/FormsViewPhotos/date.svg',
          ),
        ),
      ),
      hintText: widget.hintText,
      width: 160,
      height: 45,
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
