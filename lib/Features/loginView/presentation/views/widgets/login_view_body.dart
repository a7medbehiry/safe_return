import 'package:flutter/material.dart';
import 'custom_bottom_part.dart';
import 'custom_top_part.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomTopPart(),
        CustomBottomPart(),
      ],
    );
  }
}
