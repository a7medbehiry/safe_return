import 'package:flutter/material.dart';
import 'widgets/opening_view_body.dart';

class OpeningView extends StatelessWidget {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OpeningViewBody(),
    );
  }
}