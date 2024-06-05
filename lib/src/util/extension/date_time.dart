import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addTime({int hour = 0, int minute = 0}) {
    return replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}

extension DateTimeExtension on DateTime {
  DateTime toLocalDateTime({String format = "yyyy-MM-dd HH:mm:ss"}) {
    var dateTime = DateFormat(format).parse(toString(), true);
    return dateTime.toLocal();
  }
}

extension DateFormatExtension on String {
  String toCustomDateFormat() {
    // Parse the UTC datetime string
    DateTime utcDateTime = DateTime.parse(this);

    // Define the desired output format
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

    // Format the datetime to the desired string format
    String formattedStr = formatter.format(utcDateTime);

    return formattedStr;
  }
}
