// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomListingModelImpl _$$RoomListingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RoomListingModelImpl(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      floor: json['floor'] as String?,
    );

Map<String, dynamic> _$$RoomListingModelImplToJson(
        _$RoomListingModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'floor': instance.floor,
    };
