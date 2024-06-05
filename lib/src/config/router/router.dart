import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';

import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
import '../../bottomNavigationbar/bottomnavigationbar.dart';
import '../../modouls/booking /confirm_booking.dart';

import '../../modouls/booking /page/booking_room_datails.dart';
import '../../modouls/booking /page/event_calendar_page.dart';
import '../../modouls/listing/model/room_listing_model.dart';
import '../../modouls/listing/page/listing_room.dart';
import '../../modouls/profile/page/profile_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = Get.key;
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
const _initialLocation = '/login';

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: _initialLocation,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, state, child) {
          return ButtomNavigationBar(
            child: child,
          );
        },
        routes: _shellRoute),
    GoRoute(
      path: '/sso',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RegisterScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
  ],
);
final _shellRoute = <GoRoute>[
  GoRoute(
    path: '/rooms',
    name: 'RoomListingScreen',
    pageBuilder: (context, state) => const NoTransitionPage(
      child: ListingRoom(),
    ),
    routes: [
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: 'confirm-booking',
      //   name: 'ConfirmBookingScreen',
      //   builder: (context, state) {
      //     return ConfirmBookingScreen(
      //       millisecondsSinceEpoch: int.tryParse(
      //         state.uri.queryParameters['millisecondsSinceEpoch'] ?? '',
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: 'room',
        builder: (context, state) => EventCalendarPage(
            roomListingModel: state.extra as RoomListingModel),
        // id: state.uri.queryParameters['id'] ?? '',
        // title: state.uri.queryParameters['title'] ?? '',

        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'confirm-booking',
            name: 'ConfirmBookingScreen',
            builder: (context, state) {
              return ConfirmBookingScreen(
                millisecondsSinceEpoch: int.tryParse(
                  state.uri.queryParameters['millisecondsSinceEpoch'] ?? '',
                ),
              );
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/booking-room',
    name: 'bookingroom',
    pageBuilder: (context, state) {
      return const NoTransitionPage(child: BookingRoomDetailsPage());
    },
  ),
  GoRoute(
    path: '/profile',
    name: 'profile',
    pageBuilder: (context, state) {
      return const NoTransitionPage(child: ProfilePage());
    },
  ),
];
