import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/booking_room_datails.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/edit_booking_page.dart';
import 'package:meetroombooking/src/modouls/listing/page/time_listing_page.dart';
import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
import '../../bottomNavigationbar/bottomnavigationbar.dart';
import '../../modouls/booking /page/confirm_booking.dart';
import '../../modouls/booking /page/event_calendar_page.dart';
import '../../modouls/booking /page/list_detail_page.dart';
import '../../modouls/listing/page/listing_room.dart';
import '../../modouls/profile/page/profile_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = Get.key;
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
const _initialLocation = '/splash';

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: _initialLocation,
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, state, child) {
          return ButtomNavigationBar(child: child);
        },
        routes: _shellRoute),
    GoRoute(
      path: '/splash',
      builder: (_, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (_, state) => const NoTransitionPage(
        child: RegisterScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (_, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
  ],
);

final _shellRoute = <GoRoute>[
  GoRoute(
    path: '/rooms',
    name: 'RoomListingScreen',
    pageBuilder: (_, state) => const NoTransitionPage(
      child: ListingRoom(),
    ),
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: 'room',
        builder: (_, state) {
          Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
          return EventCalendarPage(
            isEdit: false,
            roomListingModel: extra['roomListingModel'],
            meetingModel: extra['meetingModel'],
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'time-slot/:date',
            name: 'TimeSlot',
            builder: (_, state) {
              Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
              return TimeListingPage(
                  date: state.pathParameters['date'] ?? '',
                  roomListingModel: extra['roomListingModel'],
                  isEdit: false,
                  meetingModel: extra['meetingModel']);
            },
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'confirm-booking',
            name: 'ConfirmBookingScreen',
            builder: (_, state) {
              Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
              return ConfirmBookingScreen(
                  millisecondsSinceEpoch: int.tryParse(
                    state.uri.queryParameters['millisecondsSinceEpoch'] ?? '',
                  ),
                  roomListingModel: extra['roomListingModel']);
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
      path: '/booking-room',
      name: 'BookingRoom',
      pageBuilder: (_, state) {
        return const NoTransitionPage(child: ListDetailPage());
      },
      routes: [
        GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'all-booking-user',
            name: 'AllBookingUserListing',
            builder: (_, state) {
              Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
              return BookingRoomDetailsPage(roomModel: extra['roomModel']);
            },
            routes: [
              GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'edit-booking/:millisecondsSinceEpoch',
                  name: 'EditBooking',
                  builder: (_, state) {
                    Map<String, dynamic> extra =
                        state.extra as Map<String, dynamic>;
                    return EditBookingPage(
                        millisecondsSinceEpoch: int.tryParse(
                            state.pathParameters['millisecondsSinceEpoch'] ??
                                ''),
                        roomModel: extra['roomModel'],
                        meetModel: extra['meetModel']);
                  },
                  routes: [
                    GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'edit-event-date',
                        name: 'EditEventDate',
                        builder: (_, state) {
                          Map<String, dynamic> extra =
                              state.extra as Map<String, dynamic>;
                          return EventCalendarPage(
                            isEdit: true,
                            //  bool.tryParse(state.uri.queryParameters['isEdit']!),
                            meetingModel: extra['meetingModel'],
                            roomListingModel: extra['roomListingModel'],
                          );
                        },
                        routes: [
                          GoRoute(
                              parentNavigatorKey: _rootNavigatorKey,
                              path: 'edit-time-slot',
                              name: 'EditTimeslots',
                              builder: (_, state) {
                                Map<String, dynamic> extra =
                                    state.extra as Map<String, dynamic>;
                                return TimeListingPage(
                                    date:
                                        state.uri.queryParameters['date'] ?? '',
                                    isEdit: true,
                                    meetingModel: extra['meetingModel'],
                                    roomListingModel:
                                        extra['roomListingModel']);
                              }),
                        ]),
                  ]),
            ]),
      ]),
  GoRoute(
    path: '/profile',
    name: 'profile',
    pageBuilder: (_, state) {
      return const NoTransitionPage(child: ProfilePage());
    },
  ),
];
