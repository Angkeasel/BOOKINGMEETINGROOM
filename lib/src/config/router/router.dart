import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';

import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
import '../../modouls/booking /confirm_booking.dart';
import '../../modouls/booking /event_calendar_page.dart';
import '../../modouls/listing/listing_room.dart';

const _initialLocation = '/sso';
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: _initialLocation,
  routes: [
    GoRoute(
      path: '/sso',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        path: '/room',
        name: 'Room',
        builder: (context, state) => const ListingRoom(),
        routes: [
          GoRoute(
            path: 'room-meet/:id',
            builder: (context, state) {
              int id = int.parse(state.pathParameters['id']!);
              return EventCalendarPage(
                id: id,
              );
            },
          ),
          GoRoute(
              path: 'confirm-booking',
              name: 'ConfirmBooking',
              builder: (context, state) {
                return ConfirmBookingScreen(
                  amountTime: int.parse(state.uri.queryParameters['index']!),
                  time: state.uri.queryParameters['time'],
                );
              }),
        ])
  ],
);
