import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/meeting/meeting_model.dart';

class BookingController extends GetxController {
  final List<Meeting> _event = [
    Meeting(
        eventName: 'testing 1',
        backgroundColor: Colors.blue,
        from: DateTime(2024, 05, 22, 9, 0),
        isAllDay: false,
        to: DateTime(2024, 05, 22, 9, 0).add(const Duration(hours: 1))),
    Meeting(
        eventName: 'testing 2',
        backgroundColor: Colors.blue,
        from: DateTime(2024, 05, 25, 8, 0),
        isAllDay: false,
        to: DateTime(2024, 05, 25, 8, 0).add(const Duration(minutes: 30)))
  ];
  List<Meeting> get events => _event;

  void addEvent(Meeting event) {
    _event.add(event);
  }

  List<String> colors = [
    "#540000",
    "#F5821F",
    "#4E9B8F",
  ];
  final isSelected = 0.obs;
}
