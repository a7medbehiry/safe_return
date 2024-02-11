import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:safe_return/core/utils/widgets/custom_text_field.dart';

class CustomSignUpDate extends StatefulWidget {
  const CustomSignUpDate({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSignUpDate> createState() => _CustomSignUpDateState();
}

class _CustomSignUpDateState extends State<CustomSignUpDate> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: dateInput,
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
