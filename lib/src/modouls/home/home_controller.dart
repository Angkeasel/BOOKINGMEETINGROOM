import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meetroombooking/src/modouls/booking/time_model/time_model.dart';

class HomeController extends GetxController {
  final testing = ''.obs;
  final isSelected = ''.obs;

  List<TimeModel> getGeneratedTimeSlots() {
    List<TimeModel> gtimeSlots = [];

    DateTime currentDay = DateTime.now();
    // Set the start time and end time
    TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

    // ignore: unnecessary_null_comparison
    if (endTime == null) {
      throw ArgumentError('Both startTime and endTime must be provided.');
    }

    DateTime startDateTime = currentDay
        .add(Duration(hours: startTime.hour, minutes: startTime.minute));

    DateTime endDateTime =
        currentDay.add(Duration(hours: endTime.hour, minutes: endTime.minute));

    if (startDateTime.isAfter(endDateTime)) {
      throw ArgumentError('endTime must be after startTime');
    }

    while (startDateTime.isBefore(endDateTime)) {
      DateTime endSlot = startDateTime.add(const Duration(minutes: 30));
      if (endSlot.isAfter(endDateTime)) {
        endSlot = endDateTime;
      }
      TimeModel timeModel = TimeModel(
          startTime: startDateTime, endTime: endSlot, currentDay: currentDay);
      gtimeSlots.add(timeModel);
      debugPrint(
          '=====>show model ${timeModel.startTime} - ${timeModel.endTime}');
      // gtimeSlots.add({
      //   'startTime': TimeOfDay.fromDateTime(startDateTime).format(context),
      //   'endTime': TimeOfDay.fromDateTime(endSlot).format(context),
      // });

      startDateTime = endSlot;
    }

    return gtimeSlots;
  }

  // Iterable<TimeOfDay> generateAllTimeSlots(
  //     TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
  //   var hour = startTime.hour;
  //   var minute = startTime.minute;
  //   do {
  //     yield TimeOfDay(hour: hour, minute: minute);
  //     minute += step.inMinutes;
  //     while (minute >= 60) {
  //       minute -= 60;
  //       hour++;
  //     }
  //   } while (hour < endTime.hour ||
  //       (hour == endTime.hour && minute <= endTime.minute));
  // }

  void setDefaultDropdown() {
    dropdownvalue(30);
  }

  final newdropdownValue = 30.obs;
  final dropdownvalue = 30.obs;
  final dropdownvalueIndex = 0.obs;
  // final newdropdownvalueIndex = 0.obs;
  List<int> dropdownAddTimeList = [
    30,
    60,
    90,
    120,
    150,
    300,
  ];
}
