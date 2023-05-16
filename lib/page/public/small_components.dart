import 'package:password_folder_app/i18n/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///输入校验f
String? inputValidator(String? value, String name) {
  if (value == null || value.trim().isEmpty) {
    return name + LanguageText.cannotBeEmpty.tr;
  }
  return null;
}

///下一步
TextInputAction next() {
  return TextInputAction.next;
}


