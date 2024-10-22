import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/booking_room_datails.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/edit_booking_page.dart';
import 'package:meetroombooking/src/modouls/booking%20/page/verify_booking.dart';
import 'package:meetroombooking/src/modouls/listing/page/time_listing_page.dart';
import 'package:meetroombooking/src/modouls/profile/page/edit_profile_page.dart';
import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
import '../../bottomNavigationbar/bottomnavigationbar.dart';
import '../../modouls/booking /page/confirm_booking.dart';
import '../../modouls/booking /page/event_calendar_page.dart';
import '../../modouls/booking /page/list_detail_page.dart';
import '../../modouls/listing/page/listing_room.dart';
import '../../modouls/profile/page/profile_page.dart';
import '../../util/helper/local_storage/local_storage.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = Get.key;
final GlobalKey<NavigatorState> _shellNavigatorCalendarKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellCalendar');
final _shellNavigatorBookedKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellBooked');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
const _initialLocation = '/splash';

final router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) async {
    final isAuthenticated = await LocalStorage.getStringValue(
        key: 'access_token'); // your logic to check if user is authenticated
    if (isAuthenticated == '') {
      return '/login';
    } else {
      return null; // return "null" to display the intended route without redirecting
    }
  },
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
        StatefulShellBranch(navigatorKey: _shellNavigatorCalendarKey, routes: [
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
        StatefulShellBranch(navigatorKey: _shellNavigatorBookedKey, routes: [
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
        StatefulShellBranch(navigatorKey: _shellNavigatorProfileKey, routes: [
          GoRoute(
              path: '/profile',
              name: 'ProfileScreen',
              pageBuilder: (_, state) {
                return const NoTransitionPage(child: ProfilePage());
              },
              routes: [
                GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'edit-profile',
                    name: 'EditProfile',
                    builder: (_, state) {
                      return EditProfilePage(
                        username: state.queryParameters['username'] ?? '',
                        email: state.queryParameters['email'] ?? '',
                        image: state.queryParameters['image'] ?? '',
                      );
                    })
              ]),
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
