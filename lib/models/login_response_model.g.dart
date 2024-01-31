// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponseModel _$$_LoginResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_LoginResponseModel(
      accessToken: json['accessToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
      refreshExpiresIn: json['refreshExpiresIn'] as int?,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
      notBeforePolicy: json['notBeforePolicy'] as int?,
      sessionState: json['sessionState'] as String?,
      scope: json['scope'] as String?,
      userData: json['userData'] == null
          ? null
          : UserDto.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LoginResponseModelToJson(
        _$_LoginResponseModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'notBeforePolicy': instance.notBeforePolicy,
      'sessionState': instance.sessionState,
      'scope': instance.scope,
      'userData': instance.userData?.toJson(),
    };
