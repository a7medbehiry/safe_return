import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';

import 'custom_animated_container.dart';

class CustomAnimatedContainerActivation extends StatefulWidget {
  const CustomAnimatedContainerActivation(
      {super.key, required this.onGenderSelected});
  final void Function(Gender) onGenderSelected;
  @override
  State<CustomAnimatedContainerActivation> createState() =>
      _CustomAnimatedContainerActivationState();
}

class _CustomAnimatedContainerActivationState
    extends State<CustomAnimatedContainerActivation> {
  final List<String> animatedContainerPhotos = const [
    'assets/signUpViewPhotos/female.svg',
    'assets/signUpViewPhotos/male.svg',
  ];
  final List<String> animatedContainerTexts = const [
    'Female',
    'Male',
  ];
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                selectedGender = index == 0 ? Gender.female : Gender.male;
                widget.onGenderSelected(selectedGender!);
                setState(() {});
              },
              child: CustomAnimatedContainer(
                isActive: selectedGender ==
                    (index == 0 ? Gender.female : Gender.male),
                text: animatedContainerTexts[index],
                image: animatedContainerPhotos[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
