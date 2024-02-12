import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/constants.dart';

import 'custom_profile_text_field.dart';

class CustomProfileDate extends StatefulWidget {
  final bool enabled;
  const CustomProfileDate({
    Key? key,
    this.enabled = false,
  }) : super(key: key);

  @override
  State<CustomProfileDate> createState() => _CustomProfileDateState();
}

class _CustomProfileDateState extends State<CustomProfileDate> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomProfileTextField(
      controller: dateInput,
      enabled: widget.enabled,
      readOnly: true,
      hintText: '15-5-2002',
      prefixIcon: Center(
        child: SvgPicture.asset(
          'assets/date.svg',
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
          dateInput.text = formattedDate;
        },
      );
    }
  }
}
