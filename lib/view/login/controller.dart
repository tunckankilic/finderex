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
      } else {
        // HTTP isteği başarısız oldu.
        Get.snackbar(
          'Error',
          'Login failed. Please try again.',
          barBlur: 5,
          backgroundColor: Colors.grey[700]!.withOpacity(0.75),
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 400),
        );

        log("Response Failed");
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // HTTP isteği sırasında bir hata oluştu.
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        barBlur: 5,
        backgroundColor: Colors.grey[700]!.withOpacity(0.75),
        colorText: Colors.white,
        animationDuration: const Duration(milliseconds: 400),
      );

      log("Request Error: $error");
      throw Exception('Request failed');
    }
  }

  void login(
      {required int countryId,
      required String userName,
      required String password,
      required bool rememberMe}) async {
    if (formKey.currentState?.validate() == true) {
      Get.showOverlay(
        asyncFunction: () async {
          await loginUser(
            countryId: countryId,
            userName: userName,
            password: password,
            rememberMe: rememberMe,
          );
        },
      );
    } else {
      //shake animation maybe?
    }
  }

  void routeToRegisterPage() {
    launchUrlString('https://google.com');
  }
}
