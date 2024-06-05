import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constant/app_color.dart';
import 'controller/bottombar_controller.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final bottomBarCon = Get.put(BottomNavigationBarController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: SizedBox(
        // color: Colors.amber[800],
        height: 90,
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: _selectedIndex(context),
            onTap: (index) {
              _onItemTapped(index, context);
              bottomBarCon.activeIndex.value = index;
              bottomBarCon.update();
            },
            selectedItemColor: Colors.amber[800],
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            selectedLabelStyle: TextStyle(
                color: AppColors.primaryColor, fontWeight: FontWeight.w500),
            unselectedLabelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      bottomBarCon.activeIndex.value == 0
                          ? 'assets/image/svg/s-home.svg'
                          : 'assets/image/svg/home.svg',
                      height: 26,
                    ),
                  ],
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      SvgPicture.asset(
                        bottomBarCon.activeIndex.value == 1
                            ? 'assets/image/svg/s-calendar.svg'
                            : 'assets/image/svg/calendar.svg',
                        height: 26,
                      ),
                    ],
                  ),
                  label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      SvgPicture.asset(
                        bottomBarCon.activeIndex.value == 2
                            ? 'assets/image/svg/s-profile.svg'
                            : 'assets/image/svg/profile.svg',
                        height: 26,
                      ),
                    ],
                  ),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

_selectedIndex(BuildContext context) {
  final bottomBarCon = Get.put(BottomNavigationBarController());
  final String location = GoRouterState.of(context).uri.toString();

  if (location.startsWith('/profile')) {
    return 2;
  }
  if (location.startsWith('/booking-room')) {
    // bottomBarCon.activeIndex(1);
    // debugPrint("RETURNED");
    return 1;
  }
  if (location == '/rooms') {
    bottomBarCon.activeIndex(0);
    return 0;
  }
  return 0;
}

_onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      GoRouter.of(context).go('/rooms');
      break;
    case 1:
      GoRouter.of(context).go('/booking-room');
      break;
    case 2:
      GoRouter.of(context).go('/profile');
      break;
  }
}
