import 'package:password_folder_app/bean/global_settings.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

///主题类型定义
class ThemeType {
  ///动态主题
  static const String auto = 'auto';

  ///明亮主题
  static const String light = 'light';

  ///黑暗主题
  static const String dark = 'dark';
}

///主题类型定义
class ThemeColor {
  ///默认主题色
  static String def = Colors.green.value.toString();
  static MaterialColor defMC = Colors.green;

  ///获取 MaterialColor 颜色
  static MaterialColor getMC(String color) {
    debugPrint('getMC:$color');
    Color c = Color(int.parse(color));
    MaterialColor mc = ColorTools.primarySwatch(c);

    return mc;
  }

  static MaterialColor getThemeColor(String color) {
    GlobalSettings? gs = GSMap.map[GSKey.languageType];
    if (gs != null) {
      return getMC(color);
    } else {}
    return defMC;
  }
}
