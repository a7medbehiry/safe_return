import 'package:flutter/material.dart';

import 'widgets/my_reports_view_body.dart';

class MyReportsView extends StatelessWidget {
  const MyReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyReportsViewBody(),
    );
  }
}