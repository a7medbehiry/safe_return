import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'package:safe_return/core/utils/widgets/custom_shield.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import 'custom_shape.dart';

class OpeningViewBody extends StatelessWidget {
  const OpeningViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomShape(),
        const SizedBox(
          height: 50,
        ),
        CustomButton(
          onTap: () {
            GoRouter.of(context).push('/loginView');
          },
          width: 147,
          height: 40,
          text: Text(
            'let\'s get started',
            style: Styles.textStyleSemi16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.only(
            top: 80,
            left: 28,
          ),
          child: CustomShield()
        )
      ],
    );
  }
}
