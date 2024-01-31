import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@unfreezed
class LoginResponseModel with _$LoginResponseModel {
  const LoginResponseModel._();

  factory LoginResponseModel({
    String? accessToken,
    int? expiresIn,
    int? refreshExpiresIn,
    String? refreshToken,
    String? tokenType,
    int? notBeforePolicy,
    String? sessionState,
    String? scope,
    UserDto? userData,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }
}
