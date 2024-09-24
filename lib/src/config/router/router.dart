import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/booking_room_datails.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/edit_booking_page.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/verify_booking.dart';
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
final GlobalKey<NavigatorState> _shellNavigatorAKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
const _initialLocation = '/splash';

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: _initialLocation,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(navigatorKey: _shellNavigatorAKey, routes: [
          GoRoute(
            path: '/rooms',
            name: 'RoomListingScreen',
            pageBuilder: (_, state) {
              return const NoTransitionPage(
                child: ListingRoom(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'room/:id',
                builder: (_, state) {
                  final id = state.pathParameters['id'];
                  return EventCalendarPage(
                    isEdit: false,
                    id: id,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'time-slot',
                name: 'TimeSlot',
                builder: (_, state) {
                  return TimeListingPage(
                    date: state.queryParameters['date'] ?? '',
                    id: state.queryParameters['id'] ?? '',
                    isEdit: false,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'confirm-booking',
                name: 'ConfirmBookingScreen',
                builder: (_, state) {
                  return ConfirmBookingScreen(
                    millisecondsSinceEpoch: int.tryParse(
                      state.queryParameters['millisecondsSinceEpoch'] ?? '',
                    ),
                    id: state.queryParameters['id'] ?? '',
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'verify-booking/:id',
                name: 'VerifyBooking',
                builder: (_, state) {
                  // Map<String, dynamic> extra =
                  //     state.extra as Map<String, dynamic>;
                  return Verifybooking(
                    //meeting: extra['meeting'],
                    id: state.pathParameters['id'] ?? '',
                  );
                },
              ),
            ],
          ),
        ]),
        StatefulShellBranch(navigatorKey: _shellNavigatorBKey, routes: [
          GoRoute(
              path: '/booking-room',
              name: 'BookingRoom',
              pageBuilder: (_, state) {
                return const NoTransitionPage(child: ListDetailPage());
              },
              routes: [
                GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: ':id',
                    name: 'AllBookingUserListing',
                    builder: (_, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return BookingRoomDetailsPage(
                        id: id,
                      );
                    },
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'edit-booking',
                        name: 'EditBooking',
                        builder: (BuildContext context, state) {
                          return EditBookingPage(
                            bookId: state.queryParameters['bookId'] ?? '',
                            millisecondsSinceEpoch: int.tryParse(
                                    state.queryParameters[
                                            'millisecondsSinceEpoch'] ??
                                        '') ??
                                0,
                          );
                        },
                      ),
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: 'edit-event-date/:id',
                        name: 'EditEventDate',
                        builder: (_, state) {
                          final id = state.pathParameters['id'];
                          return EventCalendarPage(
                            isEdit: true,
                            id: id,
                          );
                        },
                      ),
                      GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: 'edit-time-slot',
                          name: 'EditTimeslots',
                          builder: (_, state) {
                            return TimeListingPage(
                              id: state.pathParameters['id'] ?? '',
                              date: state.queryParameters['date'] ?? '',
                              bookingId:
                                  state.queryParameters['bookingId'] ?? '',
                              isEdit: true,
                            );
                          }),
                    ]),
              ]),
        ]),
        StatefulShellBranch(navigatorKey: _shellNavigatorCKey, routes: [
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (_, state) {
              return const NoTransitionPage(child: ProfilePage());
            },
          ),
        ]),
      ],
    ),
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
