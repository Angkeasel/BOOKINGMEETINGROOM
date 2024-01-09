import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';

import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
import '../../modouls/booking /confirm_booking.dart';
import '../../modouls/booking /event_calendar_page.dart';
import '../../modouls/listing/listing_room.dart';

const _initialLocation = '/login';
final router = GoRouter(
  // debugLogDiagnostics: true,
  initialLocation: _initialLocation,
  routes: [
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
    GoRoute(
      path: '/rooms',
      name: 'RoomListingScreen',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ListingRoom(),
      ),
      routes: [
        GoRoute(
          path: ':id',
          builder: (_, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            return EventCalendarPage(id: id);
          },
          routes: [
            GoRoute(
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
    )
  ],
);
