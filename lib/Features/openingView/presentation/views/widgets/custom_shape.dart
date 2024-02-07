import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_return/core/utils/styles.dart';

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
          left: -70,
          top: -40,
          child: SvgPicture.asset(
            'assets/openingViewPhotos/shape.svg',
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
              'assets/openingViewPhotos/family.png',
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
