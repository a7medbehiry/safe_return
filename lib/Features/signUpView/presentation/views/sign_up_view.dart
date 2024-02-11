import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

import 'widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'New Account',
      ),
      body: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SignUpViewBody(),
      ),
    );
  }
}
