// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PermissionDto _$PermissionDtoFromJson(Map<String, dynamic> json) {
  return _PermissionDto.fromJson(json);
}

/// @nodoc
mixin _$PermissionDto {
  String? get resource => throw _privateConstructorUsedError;
  set resource(String? value) => throw _privateConstructorUsedError;
  List<String>? get scopes => throw _privateConstructorUsedError;
  set scopes(List<String>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PermissionDtoCopyWith<PermissionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionDtoCopyWith<$Res> {
  factory $PermissionDtoCopyWith(
          PermissionDto value, $Res Function(PermissionDto) then) =
      _$PermissionDtoCopyWithImpl<$Res, PermissionDto>;
  @useResult
  $Res call({String? resource, List<String>? scopes});
}

/// @nodoc
class _$PermissionDtoCopyWithImpl<$Res, $Val extends PermissionDto>
    implements $PermissionDtoCopyWith<$Res> {
  _$PermissionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = freezed,
    Object? scopes = freezed,
  }) {
    return _then(_value.copyWith(
      resource: freezed == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String?,
      scopes: freezed == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PermissionDtoCopyWith<$Res>
    implements $PermissionDtoCopyWith<$Res> {
  factory _$$_PermissionDtoCopyWith(
          _$_PermissionDto value, $Res Function(_$_PermissionDto) then) =
      __$$_PermissionDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? resource, List<String>? scopes});
}

/// @nodoc
class __$$_PermissionDtoCopyWithImpl<$Res>
    extends _$PermissionDtoCopyWithImpl<$Res, _$_PermissionDto>
    implements _$$_PermissionDtoCopyWith<$Res> {
  __$$_PermissionDtoCopyWithImpl(
      _$_PermissionDto _value, $Res Function(_$_PermissionDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = freezed,
    Object? scopes = freezed,
  }) {
    return _then(_$_PermissionDto(
      resource: freezed == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String?,
      scopes: freezed == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PermissionDto implements _PermissionDto {
  _$_PermissionDto({this.resource, this.scopes});

  factory _$_PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$$_PermissionDtoFromJson(json);

  @override
  String? resource;
  @override
  List<String>? scopes;

  @override
  String toString() {
    return 'PermissionDto(resource: $resource, scopes: $scopes)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PermissionDtoCopyWith<_$_PermissionDto> get copyWith =>
      __$$_PermissionDtoCopyWithImpl<_$_PermissionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PermissionDtoToJson(
      this,
    );
  }
}

abstract class _PermissionDto implements PermissionDto {
  factory _PermissionDto({String? resource, List<String>? scopes}) =
      _$_PermissionDto;

  factory _PermissionDto.fromJson(Map<String, dynamic> json) =
      _$_PermissionDto.fromJson;

  @override
  String? get resource;
  set resource(String? value);
  @override
  List<String>? get scopes;
  set scopes(List<String>? value);
  @override
  @JsonKey(ignore: true)
  _$$_PermissionDtoCopyWith<_$_PermissionDto> get copyWith =>
      throw _privateConstructorUsedError;
}
