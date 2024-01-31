// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PermissionDto _$$_PermissionDtoFromJson(Map<String, dynamic> json) =>
    _$_PermissionDto(
      resource: json['resource'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PermissionDtoToJson(_$_PermissionDto instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'scopes': instance.scopes,
    };
