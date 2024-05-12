import 'package:flutter/material.dart';
import 'package:safe_return/constants.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomNotification extends StatelessWidget {
  final String text, date;
  const CustomNotification({
    Key? key,
    required this.text,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: kThirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Safe Return',
                      style: Styles.textStyleSemi14,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 22,
                    )
                  ],
                ),
                Text(
                  text,
                  style: Styles.textStyleReg14.copyWith(
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: Styles.textStyleBold14.copyWith(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
