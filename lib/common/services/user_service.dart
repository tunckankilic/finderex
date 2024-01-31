// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:finderexapp/common/requests/login_user_request.dart';
// import 'package:finderex_notification_app/data/models/login_response_model.dart';
// import 'package:finderex_notification_app/domain/repositories/authentication_repository.dart';
// import 'package:finderexapp/models/delete_account_response_model.dart';
// import 'package:finderexapp/models/login_response_model.dart';
// import 'package:finderexapp/repositories/authentication_repository.dart';
// import 'package:finderexapp/repositories/user_repository.dart';
// import 'package:injectable/injectable.dart';

// import 'package:finderex_notification_app/domain/repositories/user_repository.dart';
// import 'package:stacked/stacked.dart';

// import '../../injection/injection_container.dart';

// import '../models/delete_account_response_model.dart';
// import '../models/user_model.dart';

// import '../requests/delete_user_request.dart';

// import '_data_service.dart';
// import 'user_local_service.dart';

// export 'user_local_service.dart';

// @LazySingleton()
// class UserService extends DataService
//     implements UserRepository, AuthenticationRepository {
//   UserLocalService localService = UserLocalService();
//   @override
//   Future<DataModel<LoginResponseModel>> login(
//       String emailAddress, String password) async {
//     return getData<LoginResponseModel>(
//       parseModel: LoginResponseModel.new,
//       request: LoginUserRequest().loginUser(
//           userName: userName,
//           password: password,
//           countryId: countryId,
//           rememberMe: rememberMe),
//       mockUrl: 'test/mock/login_response_model.json',
//       saveCache: locator<UserLocalService>().saveUser,
//     );
//   }

//   @override
//   Future<DataModel<DeleteAccountResponseModel>> deleteAccount() async {
//     final response = await getData<DeleteAccountResponseModel>(
//       parseModel: DeleteAccountResponseModel.new,
//       request: DeleteUserRequest(),
//     );
//     return response;
//   }

//   @override
//   Future<void> logout() async {
//     await localService.deleteUser();
//   }

//   @override
//   Future<void> sendFCMToken() async {
//     //
//   }
// }
