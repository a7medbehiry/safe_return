import 'package:flutter/material.dart';
import 'package:safe_return/Features/signUpView/presentation/views/widgets/custom_animated_container.dart';

class CustomAnimatedContainerActivation extends StatefulWidget {
  const CustomAnimatedContainerActivation({super.key});

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
  int? activeIndex;

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
                activeIndex = index;
                setState(() {});
              },
              child: CustomAnimatedContainer(
                isActive: activeIndex == index,
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
