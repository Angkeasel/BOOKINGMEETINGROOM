import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: SvgPicture.asset(
              selectedIndex == 0
                  ? 'assets/image/svg/s-calendar.svg'
                  : 'assets/image/svg/calendar.svg',
              height: 26,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Booked',
            icon: SvgPicture.asset(
              selectedIndex == 1
                  ? 'assets/image/svg/booked green.svg'
                  : 'assets/image/svg/booked black.svg',
              height: 22,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset(
              selectedIndex == 2
                  ? 'assets/image/svg/s-profile.svg'
                  : 'assets/image/svg/profile.svg',
              height: 26,
            ),
          ),
        ],
        onTap: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: context.height, minWidth: context.width * 0.1),
              child: IntrinsicHeight(
                child: NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: <NavigationRailDestination>[
                    NavigationRailDestination(
                      label: const Text('Calendar'),
                      icon: SvgPicture.asset(
                        selectedIndex == 0
                            ? 'assets/image/svg/s-calendar.svg'
                            : 'assets/image/svg/calendar.svg',
                        height: 26,
                      ),
                    ),
                    NavigationRailDestination(
                      label: const Text('Booked'),
                      icon: SvgPicture.asset(
                        selectedIndex == 1
                            ? 'assets/image/svg/booked green.svg'
                            : 'assets/image/svg/booked black.svg',
                        height: 22,
                      ),
                    ),
                    NavigationRailDestination(
                      label: const Text('Profile'),
                      icon: SvgPicture.asset(
                        selectedIndex == 2
                            ? 'assets/image/svg/s-profile.svg'
                            : 'assets/image/svg/profile.svg',
                        height: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(child: body),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'controller/bottombar_controller.dart';

// class ButtomNavigationBar extends StatelessWidget {
//   const ButtomNavigationBar({
//     super.key,
//     required this.child,
//   });
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     final bottomBarCon = Get.put(BottomNavigationBarController());
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       // resizeToAvoidBottomInset: false,
//       body: child,
//       bottomNavigationBar: Obx(
//         () => BottomNavigationBar(
//           currentIndex: _selectedIndex(context),
//           onTap: (index) {
//             _onItemTapped(index, context);
//             bottomBarCon.activeIndex.value = index;
//             bottomBarCon.update();
//           },
//           // selectedItemColor: Colors.amber[800],
//           type: BottomNavigationBarType.fixed,
//           elevation: 0,
//           selectedFontSize: 14,
//           unselectedFontSize: 14,
//           // selectedLabelStyle: TextStyle(
//           //     color: AppColors.primaryColor, fontWeight: FontWeight.w500),
//           // unselectedLabelStyle:
//           //     const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//           items: [
//             BottomNavigationBarItem(
//               icon: Column(
//                 children: [
//                   SvgPicture.asset(
//                     bottomBarCon.activeIndex.value == 0
//                         ? 'assets/image/svg/s-calendar.svg'
//                         : 'assets/image/svg/calendar.svg',
//                     height: 26,
//                   ),
//                 ],
//               ),
//               label: 'Calendar',
//             ),
//             BottomNavigationBarItem(
//                 icon: Column(
//                   children: [
//                     SvgPicture.asset(
//                       bottomBarCon.activeIndex.value == 1
//                           ? 'assets/image/svg/booked green.svg'
//                           : 'assets/image/svg/booked black.svg',
//                       height: 22,
//                     ),
//                   ],
//                 ),
//                 label: 'Booked'),
//             BottomNavigationBarItem(
//                 icon: Column(
//                   children: [
//                     SvgPicture.asset(
//                       bottomBarCon.activeIndex.value == 2
//                           ? 'assets/image/svg/s-profile.svg'
//                           : 'assets/image/svg/profile.svg',
//                       height: 26,
//                     ),
//                   ],
//                 ),
//                 label: 'Profile'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// _selectedIndex(BuildContext context) {
//   // final bottomBarCon = Get.put(BottomNavigationBarController());
//   //final String location = GoRouterState.of(context).uri.toString();
//   final String location = GoRouterState.of(context).location;

//   if (location.startsWith('/profile')) {
//     return 2;
//   }
//   if (location.startsWith('/booking-room')) {
//     // bottomBarCon.activeIndex(1);
//     // debugPrint("RETURNED");
//     return 1;
//   }
//   if (location.startsWith('/rooms')) {
//     //bottomBarCon.activeIndex(0);
//     return 0;
//   }
//   // return 0;
// }

// _onItemTapped(int index, BuildContext context) {
//   switch (index) {
//     case 0:
//       context.go('/rooms');
//       break;
//     case 1:
//       context.go('/booking-room');
//       break;
//     case 2:
//       context.go('/profile');
//       break;
//   }
// }

