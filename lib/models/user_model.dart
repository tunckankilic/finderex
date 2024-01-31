import 'package:freezed_annotation/freezed_annotation.dart';

import 'permission_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

_toJsonPerm(List<PermissionDto>? p) {
  return p?.map((e) => e.toJson()).toList();
}

@unfreezed
class UserDto with _$UserDto {
  factory UserDto({
    String? userName,
    List<String>? roles,
    @JsonKey(toJson: _toJsonPerm) List<PermissionDto>? permissions,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
