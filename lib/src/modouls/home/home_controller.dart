import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final testing = ''.obs;
  final isSelected = ''.obs;

  Iterable<TimeOfDay> generateAllTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;
    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  final dropdownvalue = '30 minutes'.obs;
  final dropdownvalueIndex = 0.obs;
  List<String> dropdownAddTimeList = [
    '30 minutes',
    '1 hours',
    '2 hours',
    '3 hours',
    '4 hours',
    '5 hours',
    '6 hours',
    '7 hours',
    '8 hours',
    '9 hours',
    '10 hours',
  ];
  int updateAddTime(int index) {
    if (index == 0) {
      return 1;
    } else if (index == 1) {
      return 2;
    } else if (index == 2) {
      return 3;
    } else if (index == 3) {
      return 4;
    } else if (index == 4) {
      return 5;
    } else if (index == 5) {
      return 6;
    } else if (index == 6) {
      return 7;
    } else if (index == 7) {
      return 8;
    } else if (index == 8) {
      return 9;
    } else if (index == 9) {
      return 10;
    } else if (index == 10) {
      return 11;
    }

    return 1;
  }
  // final daySuffix = ''.obs;
  // String getDaySuffix(int day) {
  //   if (day >= 11 && day <= 13) {
  //     return 'th';
  //   }
  //   switch (day % 10) {
  //     case 1:
  //       return 'st';
  //     case 2:
  //       return 'nd';
  //     case 3:
  //       return 'rd';
  //     default:
  //       return 'th';
  //   }
  // }

  // formatDateWithDaySuffix(DateTime date) {
  //   DateFormat dateFormat = DateFormat('d');
  //   debugPrint('=====> dayformat $dateFormat');
  //   int day = int.parse(dateFormat.format(date));
  //   debugPrint('======> day $day');
  //   daySuffix.value = getDaySuffix(day);
  //   debugPrint('======> daySuffix ${daySuffix.value}');
  //   // Format the date with the day and suffix
  //   DateFormat formattedDateFormat = DateFormat('${daySuffix.value} ');
  //   return formattedDateFormat.format(date);
  // }
  // List<String> createTimeSlots(String fromTime, String toTime) {
  //   List<String> timeSlots = [];
  //   DateTime startTime = DateFormat('HH:mm').parse(fromTime);
  //   DateTime endTime = DateFormat('HH:mm').parse(toTime);
  //   if (startTime.isBefore(endTime)) {
  //     String formatTime = startTime.hour.toString();
  //     timeSlots.add(formatTime);
  //     startTime = startTime.add(const Duration(minutes: 30));
  //   }

  //   return timeSlots;
  // }

  // List<String> setTimeSlots = [];
}
