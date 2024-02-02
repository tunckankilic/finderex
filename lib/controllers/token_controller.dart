import 'package:finderex/controllers/token_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenController extends GetxController {
  late RxString token;

  @override
  void onInit() {
    super.onInit();
    token = "".obs;
    getToken();
  }

  Future<void> getToken() async {
    var sp = await SharedPreferences.getInstance();
    token.value = sp.getString(TokenStorage.sTokenKey) ?? '';
  }

  Future<void> saveToken(String newToken) async {
    token.value = newToken;
    var sp = await SharedPreferences.getInstance();
    await sp.setString(TokenStorage.sTokenKey, newToken);
  }
}
