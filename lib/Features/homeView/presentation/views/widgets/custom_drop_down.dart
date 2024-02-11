import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/core/utils/styles.dart';

import '../../../../../constants.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.width, required this.height});
  final double width, height;
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> governorate = [
    'Alexandria',
    'Aswan',
    'Asyut',
    'Beheira',
    'Beni Suef',
    'Cairo',
    'Dakahlia',
    'Damietta',
    'Fayoum',
    'Gharbia',
    'Giza',
    'Ismailia',
    'Kafr El Sheikh',
    'Luxor',
    'Matrouh',
    'Minya',
    'Monufia',
    'New Valley',
    'North Sinai',
    'Port Said',
    'Qalyubia',
    'Qena',
    'Red Sea',
    'Sharqia',
    'Sohag',
    'South Sinai',
    'Suez',
  ];
  String? selectedGovernorate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/missingPersonFormViewPhotos/location.svg',
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          DropdownButton(
            menuMaxHeight: 250,
            value: selectedGovernorate,
            dropdownColor: kThirdColor,
            hint: const Text(
              'Governorate',
              style: Styles.textStyleReg16,
            ),
            icon: SvgPicture.asset(
              'assets/missingPersonFormViewPhotos/dropDown.svg',
            ),
            items: governorate.map(
              (String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              },
            ).toList(),
            onChanged: (String? city) {
              setState(
                () {
                  selectedGovernorate = city!;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
