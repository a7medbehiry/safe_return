import 'package:flutter/material.dart';

import 'widgets/check_mail_view_body.dart';

class CheckMailView extends StatelessWidget {
  const CheckMailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: CheckMailViewBody(),
      ),
    );
  }
}
