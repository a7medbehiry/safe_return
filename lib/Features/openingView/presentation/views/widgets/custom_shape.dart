import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/styles.dart';
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
          height: 600,
        ),
        Positioned(
          right: -45,
          top: -25,
          child: Container(
            width: 171,
            height: 132,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: -35,
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
          left: 100,
          top: -30,
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
          left: -20,
          top: -30,
          child: Container(
            width: 189,
            height: 160,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -110,
          top: 50,
          child: Container(
            width: 171,
            height: 132,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Positioned(
          left: 135,
          top: 120,
          child: Text(
            'Safe Return',
            style: Styles.textStyle24,
          ),
        ),
        const Positioned(
          left: .1,
          right: .1,
          top: 120,
          child: Image(
            image: AssetImage(
              'assets/openingViewPhoto.png',
            ),
          ),
        ),
        const Positioned(
          left: 76,
          bottom: 1,
          child: Text(
            'Bring Lost Smiles Home & Reunite Hearts',
            style: Styles.textStyle12,
          ),
        ),
      ],
    );
  }
}
