import 'package:flutter/material.dart';
import 'package:safe_return/core/utils/widgets/custom_navigation_bottom_bar.dart';

import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBottomBar(),
      body: ProfileViewBody(),
    );
  }
}
