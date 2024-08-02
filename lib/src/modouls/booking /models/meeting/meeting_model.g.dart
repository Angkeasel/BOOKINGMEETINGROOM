// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeetingImpl _$$MeetingImplFromJson(Map<String, dynamic> json) =>
    _$MeetingImpl(
      id: json['_id'] as String?,
      byRoom: json['byRoom'] as String?,
      user: json['user'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location: json['location'] as String?,
      meetingTopic: json['meetingTopic'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      date: json['date'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      isAllDay: json['isAllDay'] as bool?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MeetingImplToJson(_$MeetingImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'byRoom': instance.byRoom,
      'user': instance.user,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'meetingTopic': instance.meetingTopic,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'date': instance.date,
      'backgroundColor': instance.backgroundColor,
      'isAllDay': instance.isAllDay,
      'duration': instance.duration,
    };
