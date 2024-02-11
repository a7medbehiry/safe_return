import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/custom_navigation_bottom_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  CustomNavigationBottomBar(),
    );
  }
}


