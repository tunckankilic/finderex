import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenController extends GetxController {
  late RxString token;

  @override
  void onInit() {
    super.onInit();
    token = "".obs;
    getToken();
  }

  Future<void> getToken() async {
    final tokenBox = await Hive.openBox<String>('tokenBox');
    token.value = tokenBox.get('token') ?? '';
  }

  Future<void> saveToken(String newToken) async {
    token.value = newToken;
    final tokenBox = await Hive.openBox<String>('tokenBox');
    await tokenBox.put('token', newToken);
  }
}
