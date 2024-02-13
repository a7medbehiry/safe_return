import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';

class CustomMyReportsDropDown extends StatefulWidget {
  const CustomMyReportsDropDown({super.key});

  @override
  State<CustomMyReportsDropDown> createState() =>
      _CustomMyReportsDropDownState();
}

class _CustomMyReportsDropDownState extends State<CustomMyReportsDropDown> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        color: kThirdColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/myReportsPhotos/girl.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Report ',
                      style: Styles.textStyleReg14,
                    ),
                    Text(
                      'Lost',
                      style: Styles.textStyleBold14,
                    ),
                  ],
                ),
                Text(
                  'Date: 27/1/2024',
                  style: Styles.textStyleReg14,
                ),
                Text(
                  'Name: Sohaila Ali',
                  style: Styles.textStyleReg14,
                ),
                Text(
                  'National ID: 5060701265348',
                  style: Styles.textStyleReg14,
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  dropdownColor: kThirdColor,
                  value: selectedOption,
                  icon: SvgPicture.asset('assets/myReportsPhotos/dropDown.svg'),
                  style: Styles.textStyleReg16.copyWith(color: Colors.black),
                  onChanged: (data) {
                    setState(() {
                      selectedOption = data;
                    });
                  },
                  items: <String>['Edit', 'Delete']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Text(value),
                          const SizedBox(
                            width: 10,
                          ),
                          value == 'Edit'
                              ? SvgPicture.asset(
                                  'assets/myReportsPhotos/edit.svg')
                              : SvgPicture.asset(
                                  'assets/myReportsPhotos/delete.svg'),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Text(
                  '10:15 AM',
                  style: Styles.textStyleBold14.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
