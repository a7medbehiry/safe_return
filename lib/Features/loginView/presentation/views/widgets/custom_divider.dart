import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.23,
          child: const Divider(
            thickness: 1,
            color: Color(0xffA5A5A5),
            indent: 0,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Center(
          child: Text(
            'OR',
            style: Styles.textStyleReg16.copyWith(
              color: const Color(0xffA5A5A5),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.23,
          child: const Divider(
            thickness: 1,
            color: Color(0xffA5A5A5),
            indent: 0,
          ),
        ),
      ],
    );
  }
}
