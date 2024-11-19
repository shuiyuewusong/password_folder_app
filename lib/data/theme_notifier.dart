import 'package:password_folder_app/data/theme.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  static late ThemeData _themeDataLight;

  static ThemeData? _themeDataDark;

  static late Locale? _deviceLocale;

  ThemeData get getThemeDataLight {
    return _themeDataLight;
  }

  ThemeData? get getThemeDataDark {
    return _themeDataDark;
  }

  Locale? get getDeviceLocale {
    return _deviceLocale;
  }

  ThemeNotifier() {
    debugPrint('ThemeColorData:new');
    _setTheme(
        GSMap.map[GSKey.themeType]!.value, GSMap.map[GSKey.themeColor]!.value);

    // initRun(context);
  }

  void setThemeAll() {
    _setTheme(
        GSMap.map[GSKey.themeType]!.value, GSMap.map[GSKey.themeColor]!.value);
    debugPrint('ThemeColorData: ThemeData :data');
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _deviceLocale = locale;
    debugPrint('ThemeColorData:Locale: data');
    notifyListeners();
  }

  ///设置主题
  void _setTheme(String themeType, String colorStr) {
    MaterialColor mc = ThemeColor.getThemeColor(colorStr);
    //设置明亮主题
    final tdLight = ThemeData(
      //primaryColor: mc,
      //colorSchemeSeed: mc,
      colorScheme: ColorScheme.fromSeed(
          seedColor: mc, primary: mc, brightness: Brightness.light),
    );
    //设置暗黑主题
    final tdDark = ThemeData(
      //colorSchemeSeed: mc,
      // colorScheme:
      colorScheme: ColorScheme.fromSeed(
          seedColor: mc, primary: mc, brightness: Brightness.dark),
      //brightness: Brightness.dark,
    );
    switch (themeType) {
      case ThemeType.auto:
        //设置明亮主题
        _themeDataLight = tdLight;
        //设置暗黑主题
        _themeDataDark = tdDark;
        break;
      case ThemeType.light:
        //设置明亮主题

        _themeDataLight = tdLight;
        //设置暗黑主题
        _themeDataDark = tdLight;
        break;
      case ThemeType.dark:
        //设置暗黑主题
        _themeDataLight = tdDark;
        _themeDataDark = tdDark;
        break;
      default:
        debugPrint('_setTheme');
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('AppData:disposed');
  }
}
