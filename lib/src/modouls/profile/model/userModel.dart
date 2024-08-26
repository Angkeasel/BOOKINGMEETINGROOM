import 'package:freezed_annotation/freezed_annotation.dart';

part 'userModel.freezed.dart';
part 'userModel.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel(
      {final String? email,
      final String? username,
      final String? avatar}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
