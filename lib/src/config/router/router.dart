import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/modouls/booking%20/event_calendar_page.dart';
import 'package:meetroombooking/src/modouls/home/my_home_page.dart';

import 'package:meetroombooking/src/modouls/listing/listing_room.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'HomePage',
      builder: (context, state) => const MyHomePage(),
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
