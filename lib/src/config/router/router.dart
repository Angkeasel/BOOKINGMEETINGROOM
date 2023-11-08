import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/auth/page/register_screen.dart';

import '../../auth/page/login_screen.dart';
import '../../auth/page/splash_screen.dart';
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
            path: 'booking',
            name: 'Booking',
            builder: (context, state) => const EventCalendarPage(),
          ),
        ])
  ],
);
