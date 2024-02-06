import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class CustomShape extends StatelessWidget {
  const CustomShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          right: -45,
          top: -35,
          child: Container(
            width: 200,
            height: 150,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: -20,
          child: Container(
            width: 189,
            height: 134,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: 90,
          top: -20,
          child: Container(
            width: 189,
            height: 134,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -15,
          top: -40,
          child: Container(
            width: 171,
            height: 150,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -110,
          top: 40,
          child: Container(
            width: 171,
            height: 132,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}