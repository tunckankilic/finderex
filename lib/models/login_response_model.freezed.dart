// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return _LoginResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseModel {
  String? get accessToken => throw _privateConstructorUsedError;
  set accessToken(String? value) => throw _privateConstructorUsedError;
  int? get expiresIn => throw _privateConstructorUsedError;
  set expiresIn(int? value) => throw _privateConstructorUsedError;
  int? get refreshExpiresIn => throw _privateConstructorUsedError;
  set refreshExpiresIn(int? value) => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  set refreshToken(String? value) => throw _privateConstructorUsedError;
  String? get tokenType => throw _privateConstructorUsedError;
  set tokenType(String? value) => throw _privateConstructorUsedError;
  int? get notBeforePolicy => throw _privateConstructorUsedError;
  set notBeforePolicy(int? value) => throw _privateConstructorUsedError;
  String? get sessionState => throw _privateConstructorUsedError;
  set sessionState(String? value) => throw _privateConstructorUsedError;
  String? get scope => throw _privateConstructorUsedError;
  set scope(String? value) => throw _privateConstructorUsedError;
  UserDto? get userData => throw _privateConstructorUsedError;
  set userData(UserDto? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginResponseModelCopyWith<LoginResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseModelCopyWith<$Res> {
  factory $LoginResponseModelCopyWith(
          LoginResponseModel value, $Res Function(LoginResponseModel) then) =
      _$LoginResponseModelCopyWithImpl<$Res, LoginResponseModel>;
  @useResult
  $Res call(
      {String? accessToken,
      int? expiresIn,
      int? refreshExpiresIn,
      String? refreshToken,
      String? tokenType,
      int? notBeforePolicy,
      String? sessionState,
      String? scope,
      UserDto? userData});

  $UserDtoCopyWith<$Res>? get userData;
}

/// @nodoc
class _$LoginResponseModelCopyWithImpl<$Res, $Val extends LoginResponseModel>
    implements $LoginResponseModelCopyWith<$Res> {
  _$LoginResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? expiresIn = freezed,
    Object? refreshExpiresIn = freezed,
    Object? refreshToken = freezed,
    Object? tokenType = freezed,
    Object? notBeforePolicy = freezed,
    Object? sessionState = freezed,
    Object? scope = freezed,
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshExpiresIn: freezed == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      notBeforePolicy: freezed == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int?,
      sessionState: freezed == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserDto?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get userData {
    if (_value.userData == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.userData!, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LoginResponseModelCopyWith<$Res>
    implements $LoginResponseModelCopyWith<$Res> {
  factory _$$_LoginResponseModelCopyWith(_$_LoginResponseModel value,
          $Res Function(_$_LoginResponseModel) then) =
      __$$_LoginResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? accessToken,
      int? expiresIn,
      int? refreshExpiresIn,
      String? refreshToken,
      String? tokenType,
      int? notBeforePolicy,
      String? sessionState,
      String? scope,
      UserDto? userData});

  @override
  $UserDtoCopyWith<$Res>? get userData;
}

/// @nodoc
class __$$_LoginResponseModelCopyWithImpl<$Res>
    extends _$LoginResponseModelCopyWithImpl<$Res, _$_LoginResponseModel>
    implements _$$_LoginResponseModelCopyWith<$Res> {
  __$$_LoginResponseModelCopyWithImpl(
      _$_LoginResponseModel _value, $Res Function(_$_LoginResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? expiresIn = freezed,
    Object? refreshExpiresIn = freezed,
    Object? refreshToken = freezed,
    Object? tokenType = freezed,
    Object? notBeforePolicy = freezed,
    Object? sessionState = freezed,
    Object? scope = freezed,
    Object? userData = freezed,
  }) {
    return _then(_$_LoginResponseModel(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshExpiresIn: freezed == refreshExpiresIn
          ? _value.refreshExpiresIn
          : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      notBeforePolicy: freezed == notBeforePolicy
          ? _value.notBeforePolicy
          : notBeforePolicy // ignore: cast_nullable_to_non_nullable
              as int?,
      sessionState: freezed == sessionState
          ? _value.sessionState
          : sessionState // ignore: cast_nullable_to_non_nullable
              as String?,
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserDto?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LoginResponseModel extends _LoginResponseModel {
  _$_LoginResponseModel(
      {this.accessToken,
      this.expiresIn,
      this.refreshExpiresIn,
      this.refreshToken,
      this.tokenType,
      this.notBeforePolicy,
      this.sessionState,
      this.scope,
      this.userData})
      : super._();

  factory _$_LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_LoginResponseModelFromJson(json);

  @override
  String? accessToken;
  @override
  int? expiresIn;
  @override
  int? refreshExpiresIn;
  @override
  String? refreshToken;
  @override
  String? tokenType;
  @override
  int? notBeforePolicy;
  @override
  String? sessionState;
  @override
  String? scope;
  @override
  UserDto? userData;

  @override
  String toString() {
    return 'LoginResponseModel(accessToken: $accessToken, expiresIn: $expiresIn, refreshExpiresIn: $refreshExpiresIn, refreshToken: $refreshToken, tokenType: $tokenType, notBeforePolicy: $notBeforePolicy, sessionState: $sessionState, scope: $scope, userData: $userData)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginResponseModelCopyWith<_$_LoginResponseModel> get copyWith =>
      __$$_LoginResponseModelCopyWithImpl<_$_LoginResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoginResponseModelToJson(
      this,
    );
  }
}

abstract class _LoginResponseModel extends LoginResponseModel {
  factory _LoginResponseModel(
      {String? accessToken,
      int? expiresIn,
      int? refreshExpiresIn,
      String? refreshToken,
      String? tokenType,
      int? notBeforePolicy,
      String? sessionState,
      String? scope,
      UserDto? userData}) = _$_LoginResponseModel;
  _LoginResponseModel._() : super._();

  factory _LoginResponseModel.fromJson(Map<String, dynamic> json) =
      _$_LoginResponseModel.fromJson;

  @override
  String? get accessToken;
  set accessToken(String? value);
  @override
  int? get expiresIn;
  set expiresIn(int? value);
  @override
  int? get refreshExpiresIn;
  set refreshExpiresIn(int? value);
  @override
  String? get refreshToken;
  set refreshToken(String? value);
  @override
  String? get tokenType;
  set tokenType(String? value);
  @override
  int? get notBeforePolicy;
  set notBeforePolicy(int? value);
  @override
  String? get sessionState;
  set sessionState(String? value);
  @override
  String? get scope;
  set scope(String? value);
  @override
  UserDto? get userData;
  set userData(UserDto? value);
  @override
  @JsonKey(ignore: true)
  _$$_LoginResponseModelCopyWith<_$_LoginResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
