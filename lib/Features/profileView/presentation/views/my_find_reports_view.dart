import 'package:flutter/material.dart';

import 'widgets/my_find_report_view_body.dart';

class MyFindReportsView extends StatelessWidget {
  const MyFindReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF3F6F6),
      body: MyFindReportsViewBody(),
    );
  }
}
