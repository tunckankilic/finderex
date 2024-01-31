import 'package:http/http.dart' as http;

class LoginUserRequest {
  void loginUser(
      {required String userName,
      required String password,
      required int countryId,
      required bool rememberMe}) async {
    var request = await http
        .post(Uri.parse("https://demoauthv2.finderex.io/v2/auth/login"), body: {
      "country_id": countryId,
      "user_name": userName,
      "password": password,
      "remember_me": rememberMe
    });
  }
}
