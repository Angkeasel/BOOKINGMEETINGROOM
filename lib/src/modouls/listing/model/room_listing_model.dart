import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_listing_model.freezed.dart';
part 'room_listing_model.g.dart';

@freezed
class RoomListingModel with _$RoomListingModel {
  factory RoomListingModel({
    final int? id,
    final String? name,
  }) = _RoomListingModel;

  factory RoomListingModel.fromJson(Map<String, dynamic> json) =>
      _$RoomListingModelFromJson(json);
}
