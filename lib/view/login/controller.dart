// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:finderex/common/services/validator.dart';
import 'package:finderex/controllers/token_storage.dart';
import 'package:finderex/models/auto_validator_model.dart';
import 'package:finderex/view/home.dart';
import 'package:finderex/view/login/view.dart';
import 'package:finderex/view/notifications/view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class LoginController extends GetxController {
  late final TapGestureRecognizer registrationTapRecognizer;

  GlobalKey<FormState> formKey = GlobalKey();

  AutoValidatorModel emailAddress = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  AutoValidatorModel password = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );
  Future<Map<String, dynamic>> loginUser({
    required int countryId,
    required String userName,
    required String password,
    required bool rememberMe,
    required BuildContext context,
  }) async {
    final url = Uri.parse('https://demoauthv2.finderex.io/v2/auth/login');
    final body = jsonEncode({
      "country_id": countryId,
      "user_name": userName,
      "password": password,
      "remember_me": rememberMe,
    });

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        log("Response: $responseData");

        String token = responseData["data"]["access"];
        log("Token: $token");
        String session = responseData["data"]["session"];
        log("Session: $session");
        // Token'ı kaydet
        await TokenStorage.saveToken(token);
        await TokenStorage.saveSession(session);

        Get.offAll(Home());
        return responseData;
      } else if (response.statusCode == 401) {
        // HTTP isteği başarısız oldu. Hatalı kullanıcı adı veya şifre.
        showLoginErrorDialogWithBackButton(
            "Kullanıcı adı veya şifre yanlış, Tekrar Deneyiniz", context);
        log("Invalid credentials");
        throw Exception('Invalid credentials');
      } else if (response.statusCode == 409) {
        // HTTP isteği başarısız oldu. Kullanıcı kimlik bilgileri geçerli değil.
        await showLoginErrorDialogWithBackButton(
            "IKullanıcı adı veya şifre yanlış, Tekrar Deneyiniz", context);
        log("Invalid credentials");
        return {}; // veya başka bir değer dönebilirsiniz, bu senaryoya bağlı
      } else {
        // Diğer hata durumları için genel hata mesajı göster.
        showLoginErrorDialogWithBackButton(
            "Hatalı Giriş, Tekrar Deneyiniz", context);
        log("Response Failed");
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // HTTP isteği sırasında bir hata oluştu.
      showLoginErrorDialogWithBackButton(
          "Bir sorun oluştu. Tekrar deneyiniz", context);
      log("Request Error: $error");
      throw Exception('Request failed: $error');
    }
  }

  Future<void> showLoginErrorDialogWithBackButton(
      String errorMessage, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(errorMessage),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Kapat alert dialog
                },
                child: Text('Geri'),
              ),
            ],
          ),
        );
      },
    );
  }

  void login(
      {required int countryId,
      required String userName,
      required String password,
      required bool rememberMe,
      required BuildContext context}) async {
    if (formKey.currentState?.validate() == true) {
      await loginUser(
        context: context,
        countryId: countryId,
        userName: userName,
        password: password,
        rememberMe: rememberMe,
      );
    } else {
      //shake animation maybe?
    }
  }

  void routeToRegisterPage() {
    launchUrlString('https://google.com');
  }
}
