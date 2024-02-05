// import 'dart:async';
// import 'dart:convert';
// import 'package:finderex/common/generators/hive_annotation.dart';
// import 'package:finderex/models/login_response_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// part 'user_local_service.g.dart';

// @HiveService('usersBox')
// class UserLocalService with _$UserLocalService {
//   Future<void> saveUser(LoginResponseModel loginResponseModel) async {
//     await _save('1', loginResponseModel.toJson());
//   }

//   LoginResponseModel? getUser() {
//     final data = _get('1');
//     return data != null ? LoginResponseModel.fromJson(data) : null;
//   }

//   Future<void> deleteUser() async {
//     await _delete('1');
//   }
// }
