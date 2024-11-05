import 'package:flutter/material.dart';
import 'package:meetroombooking/src/util/extension/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'meeting_model.dart';

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(_getMeetingData(index).startTime!);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(_getMeetingData(index).endTime!);
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).meetingTopic!;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).backgroundColor!.toColor();
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay!;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

// List<Meeting> getDataSource(String dateStringWithTimeZone) {
//   // Noted *****
//   //param date string With timezone
//   // check time avalaible and time contans before booking
//   // ehance time to post booking
//   //*********/
//   final List<Meeting> meetings = <Meeting>[];
//   //final DateTime today = DateTime.now();
//   //String dateStringWithTimeZone = '2024-05-27T14:00:00-08:00';
//   DateTime dateTimeWithTimeZone = DateTime.parse(dateStringWithTimeZone);

//   startTime({int hour = 0, int min = 0, day}) {
//     return DateTime(dateTimeWithTimeZone.year, dateTimeWithTimeZone.month,
//         dateTimeWithTimeZone.day, hour, min);
//   }

//   //final DateTime endTime = DateTime(0);
//   List<Meeting> meetingList = [
//     Meeting(
//         eventName: 'Conference 1',
//         backgroundColor: Colors.pink,
//         from: startTime(hour: 9, min: 30),
//         isAllDay: false,
//         to: startTime(hour: 9, min: 30).add(const Duration(hours: 2))),
//     Meeting(
//         eventName: 'Conference 2',
//         backgroundColor: Colors.green,
//         from: startTime(hour: 8, min: 0),
//         isAllDay: false,
//         to: startTime(hour: 8, min: 0).add(const Duration(hours: 2))),
//     Meeting(
//       eventName: 'Conference 3',
//       backgroundColor: Colors.blue,
//       from: startTime(hour: 13, min: 0),
//       isAllDay: false,
//       to: startTime(hour: 13, min: 0).add(const Duration(minutes: 30)),
//     )
//   ];
//   meetings.assignAll(meetingList);
//   return meetings;
// }
