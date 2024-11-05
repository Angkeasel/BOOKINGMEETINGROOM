// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_listing_model.freezed.dart';
part 'room_listing_model.g.dart';

@freezed
class RoomListingModel with _$RoomListingModel {
  factory RoomListingModel({
    @JsonKey(name: '_id') final String? id,
    final String? title,
    final String? image,
    final String? floor,
  }) = _RoomListingModel;

  factory RoomListingModel.fromJson(Map<String, dynamic> json) =>
      _$RoomListingModelFromJson(json);
}
