import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

AppBar customAppBar(BuildContext context,
    {final String? title, VoidCallback? onPressed, Widget? icon}) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Center(
        child: SvgPicture.asset('assets/appBarPhotos/arrow.svg'),
      ),
    ),
    backgroundColor: kPrimaryColor,
    centerTitle: true,
    title: Text(
      title ?? '',
      style: Styles.textStyleSemi15.copyWith(
        color: Colors.white,
      ),
    ),
    actions: [
      IconButton(
        icon: icon ?? const SizedBox(),
        onPressed: onPressed,
      ),
    ],
  );
}
