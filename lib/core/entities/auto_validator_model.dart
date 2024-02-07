import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AutoValidatorModel {
  late TextEditingController textController;
  late String? Function(String?) validate;
  AutoValidatorModel({
    String? initialText,
    String? Function(String?)? validator,
    bool isMoney = false,
  }) {
    if (validator == null) {
      validate = _isEmpty;
    } else {
      validate = validator;
    }

    textController = TextEditingController(text: initialText);
  }

  String? _isEmpty(String? text) {
    if (text?.isEmpty == true) {
      return 'this_field_can_not_be_empty'.tr;
    }
    return null;
  }
}
