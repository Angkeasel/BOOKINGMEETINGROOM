// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_model.freezed.dart';
part 'meeting_model.g.dart';

@freezed
class Meeting with _$Meeting {
  factory Meeting({
    @JsonKey(name: '_id') String? id,
    String? byRoom,
    String? user,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? location,
    String? meetingTopic,
    String? startTime,
    String? endTime,
    String? date,
    String? backgroundColor,
    bool? isAllDay,
    int? duration,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}

// import 'package:flutter/material.dart';

// class Meeting {
//   String firstName;
//   String lastName;
//   String email;
//   String phone;
//   String location;
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color backgroundColor;
//   bool isAllDay;
//   int duration;
//   Meeting(
//       {required this.backgroundColor,
//       required this.duration,
//       required this.email,
//       required this.eventName,
//       required this.firstName,
//       required this.from,
//       required this.isAllDay,
//       required this.lastName,
//       required this.location,
//       required this.phone,
//       required this.to});
// }
