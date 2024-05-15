import 'package:flutter/material.dart';

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color backgroundColor;
  bool isAllDay;
  Meeting(
      {required this.eventName,
      required this.backgroundColor,
      required this.from,
      required this.isAllDay,
      required this.to});
}
