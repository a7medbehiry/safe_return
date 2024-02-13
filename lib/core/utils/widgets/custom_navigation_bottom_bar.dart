import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../constants.dart';

class CustomNavigationBottomBar extends StatefulWidget {
  const CustomNavigationBottomBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<CustomNavigationBottomBar> createState() =>
      _CustomNavigationBottomBarState();
}

class _CustomNavigationBottomBarState extends State<CustomNavigationBottomBar> {
  int selectedIndex = 0;

  final _controller = NotchBottomBarController(index: 0);

  void goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 85,
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: const Color(0xffF3F6F6),
          showLabel: false,
          shadowElevation: 5,
          kBottomRadius: 0,
          notchColor: kSecondColor,
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 300,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/home_inActive.svg',
              ),
              activeItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/home_active.svg',
              ),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/notification_inActive.svg',
              ),
              activeItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/notification_active.svg',
              ),
              itemLabel: 'Notification',
            ),
            BottomBarItem(
              inActiveItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/profile_inActive.svg',
              ),
              activeItem: SvgPicture.asset(
                'assets/navigationBottomBarPhotos/profile_active.svg',
              ),
              itemLabel: 'Profile',
            ),
          ],
          onTap: (index) {
            selectedIndex = index;
            goToBranch(selectedIndex);
          },
          kIconSize: 24.0,
        ),
      ),
    );
  }
}
