// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomListingModel _$RoomListingModelFromJson(Map<String, dynamic> json) {
  return _RoomListingModel.fromJson(json);
}

/// @nodoc
mixin _$RoomListingModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomListingModelCopyWith<RoomListingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomListingModelCopyWith<$Res> {
  factory $RoomListingModelCopyWith(
          RoomListingModel value, $Res Function(RoomListingModel) then) =
      _$RoomListingModelCopyWithImpl<$Res, RoomListingModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$RoomListingModelCopyWithImpl<$Res, $Val extends RoomListingModel>
    implements $RoomListingModelCopyWith<$Res> {
  _$RoomListingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomListingModelImplCopyWith<$Res>
    implements $RoomListingModelCopyWith<$Res> {
  factory _$$RoomListingModelImplCopyWith(_$RoomListingModelImpl value,
          $Res Function(_$RoomListingModelImpl) then) =
      __$$RoomListingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$RoomListingModelImplCopyWithImpl<$Res>
    extends _$RoomListingModelCopyWithImpl<$Res, _$RoomListingModelImpl>
    implements _$$RoomListingModelImplCopyWith<$Res> {
  __$$RoomListingModelImplCopyWithImpl(_$RoomListingModelImpl _value,
      $Res Function(_$RoomListingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$RoomListingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomListingModelImpl implements _RoomListingModel {
  _$RoomListingModelImpl({this.id, this.name});

  factory _$RoomListingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomListingModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'RoomListingModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomListingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomListingModelImplCopyWith<_$RoomListingModelImpl> get copyWith =>
      __$$RoomListingModelImplCopyWithImpl<_$RoomListingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomListingModelImplToJson(
      this,
    );
  }
}

abstract class _RoomListingModel implements RoomListingModel {
  factory _RoomListingModel({final int? id, final String? name}) =
      _$RoomListingModelImpl;

  factory _RoomListingModel.fromJson(Map<String, dynamic> json) =
      _$RoomListingModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$RoomListingModelImplCopyWith<_$RoomListingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
