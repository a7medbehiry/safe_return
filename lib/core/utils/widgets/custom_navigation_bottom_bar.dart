import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_return/Features/homeView/presentation/views/widgets/home_view_body.dart';
import '../../../Features/notificationView/presentation/views/widgets/notification_view_body.dart';
import '../../../constants.dart';

class CustomNavigationBottomBar extends StatefulWidget {
  const CustomNavigationBottomBar({super.key});

  @override
  State<CustomNavigationBottomBar> createState() =>
      _CustomNavigationBottomBarState();
}

class _CustomNavigationBottomBarState extends State<CustomNavigationBottomBar> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 3;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const HomeViewBody(),
    const NotificationViewBody()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: const Color(0xffF3F6F6),
              showLabel: false,
              shadowElevation: 5,
              kBottomRadius: 28.0,
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
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
