import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/custom_navigation_bottom_bar.dart';
import 'widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBottomBar(),
      body: NotificationViewBody(),
    );
  }
}
