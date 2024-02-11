import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

AppBar customAppBar(BuildContext context, {final String? title}) {
  return AppBar(
    leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: SvgPicture.asset('assets/appBarPhotos/arrow.svg'),
        ),),
    backgroundColor: kPrimaryColor,
    centerTitle: true,
    title: Text(
      title ?? '',
      style: Styles.textStyleSemi16.copyWith(
        color: Colors.white,
      ),
    ),
  );
}
