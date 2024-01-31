import 'package:http/http.dart' as http;

class DeleteUserRequest {
  void deleteUser() async {
    var request = await http.post(
        Uri.parse("https://demoauthv2.finderex.io/v2/auth/deleteUser"),
        body: {});
  }
}
