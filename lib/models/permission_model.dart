import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_model.freezed.dart';
part 'permission_model.g.dart';

@unfreezed
class PermissionDto with _$PermissionDto {
  factory PermissionDto({
    String? resource,
    List<String>? scopes,
  }) = _PermissionDto;

  factory PermissionDto.fromJson(Map<String, dynamic> json) =>
      _$PermissionDtoFromJson(json);
}
