import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomProfileAppBar extends StatelessWidget {
  const CustomProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.25,
        ),
        Text(
          'Profile',
          style: Styles.textStyleSemi16.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 130,
        ),
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: SvgPicture.asset('assets/profileViewPhotos/menu.svg'),
        ),
      ],
    );
  }
}
