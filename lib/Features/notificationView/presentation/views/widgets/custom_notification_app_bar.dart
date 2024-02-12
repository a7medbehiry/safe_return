import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';

AppBar customNotificationAppBar() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: SvgPicture.asset('assets/appBarPhotos/arrow.svg'),
      ),
    ),
    backgroundColor: kPrimaryColor,
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Notification',
        style: Styles.textStyleSemi16.copyWith(
          color: Colors.white,
        ),
      ),
    ),
  );
}
