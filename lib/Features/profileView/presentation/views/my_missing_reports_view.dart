import 'package:flutter/material.dart';

import 'widgets/my_missing_reports_view_body.dart';

class MyMissingReportsView extends StatelessWidget {
  const MyMissingReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF3F6F6),
      body: MyMissingReportsViewBody(),
    );
  }
}
