import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ValidatorService {
  String? onlyNumber(String? text) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      RegExp regExp = RegExp(r'[^0-9-]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid number.';
      }
      return null;
    }
  }

  String? onlyDouble(String? text) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      RegExp regExp = RegExp(r'[^0-9-.,]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid number.';
      }
      return null;
    }
  }

  Pattern? onlyCorrectDouble() {
    return RegExp(r'^[0-9]*\.?[0-9]*');
  }

  String? onlyText(String? text, {int? maxLength}) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      RegExp regExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+) (*&^%0-9-]');

      if (regExp.hasMatch(text!)) {
        return 'Please enter valid text.';
      }
      if (maxLength != null) if (text.length > maxLength) {
        return 'Please enter a $maxLength digit.';
      }
      return null;
    }
  }

  String? phoneNumber(String? text) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(text!)) {
        return 'Please enter valid mobile number';
      }
      return null;
    }
  }

  String? onlyRequired(String? text, {int? maxLength}) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      if (maxLength != null) if (text!.length > maxLength) {
        return 'Please enter a $maxLength digit.';
      }
      return null;
    }
  }

  String? passwordUpperLowerNumber(String? text, {int? minLength}) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      //Number contains at least one digit
      RegExp numberExp = RegExp(r'(?=.*[0-9])');
      //Lowercase contains at least one lowercase letter
      RegExp lowerExp = RegExp(r'(?=.*[a-z])');
      //Uppercase contains at least one uppercase letter
      RegExp upperExp = RegExp(r'(?=.*[A-Z])');

      if (!numberExp.hasMatch(text!)) {
        return 'Must contain 1 number.';
      }
      if (!lowerExp.hasMatch(text)) {
        return 'Must contain 1 lowercase letter.';
      }
      if (!upperExp.hasMatch(text)) {
        return 'Must contain 1 uppercase letter.';
      }
      if (minLength != null) if (text.length < minLength) {
        return 'Please enter a $minLength digit password.';
      }
      return null;
    }
  }

  String? email(String? text) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      final isEmailCorrect = EmailValidator.validate(text!);

      if (isEmailCorrect) {
        return null;
      }
      return 'Please enter a valid email address.';
    }
  }

  String? phoneNumberWith1To12(
    String? text,
  ) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      //await Future.delayed(Duration(milliseconds: 250));

      String pattern = r'(^(?:[+0]9)?[0-9]{1,12}$)';
      RegExp regExp = RegExp(pattern);

      if (!regExp.hasMatch(text!)) {
        return 'Please enter valid mobile number.';
      }
      return null;
    }
  }

  Future<String?> validateEmailWhenStop(String? text,
      {required TextEditingController controller}) async {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      if (text == controller.text) {
        final isEmailCorrect = EmailValidator.validate(text!);

        if (isEmailCorrect) {
          return null;
        }
        return 'Please enter a valid email address.';
      }
      return '';
    }
  }
}
