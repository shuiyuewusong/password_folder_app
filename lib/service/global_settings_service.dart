import 'package:password_folder_app/bean/global_settings.dart';
import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/data/data.dart';
import 'package:password_folder_app/data/theme.dart';
import 'package:password_folder_app/data/theme_notifier.dart';
import 'package:password_folder_app/i18n/language_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

///全局变量对象键
class GSKey {
  ///语言类型键
  static const String languageType = 'languageType';

  ///主题类型键
  static const String themeType = 'themeType';

  ///主题颜色键
  static const String themeColor = 'themeColor';

  ///数据初始化
  static const String initData = 'initData';
}

///全局变量对象存储Map
class GSMap {
  static final Map<String, GlobalSettings> map = {};

  static ThemeData? darkTheme = ThemeData.dark();
}

/// 全局变量获取类
class GlobalSettingsService {
  static final GlobalSettingsService _globalSettingsService =
      GlobalSettingsService._init();

  GlobalSettingsService._init();

  factory GlobalSettingsService() {
    return _globalSettingsService;
  }

  Future<bool> init() async {
    ///初始化语言
    GlobalSettings gsLT = await getLanguageType();
    GSMap.map[gsLT.key] = gsLT;
    Get.updateLocale(Locale(gsLT.value));

    ///初始化主题
    GlobalSettings gsTT = await getThemeType();
    debugPrint('init:getThemeType:${gsTT.value}');
    GSMap.map[gsTT.key] = gsTT;

    ///初始化主题颜色
    GlobalSettings gsTC = await getThemeColor();
    debugPrint('init:getThemeColor:${gsTC.value}');
    GSMap.map[gsTC.key] = gsTC;

    ///获取初始化的状态
    GlobalSettings gsID = await getInitData();
    debugPrint('init:getThemeColor:${gsID.value}');
    GSMap.map[gsID.key] = gsID;
    return true;
  }

  ///保存全局的变量
  void setKeyValue(String key, String value) async {
    switch (key) {
      ///设置相应的语言格式
      case GSKey.languageType:
        if (value == LanguageType.auto) {
          //使用当前系统语言格式
          Get.updateLocale(Get.deviceLocale!);
        } else {
          //更新到设置的语言格式
          Get.updateLocale(Locale(value));
        }
        GSMap.map[GSKey.languageType]!.value = value;
        GlobalSettings globalSettings = await getLanguageType();
        globalSettings.value = value;
        _setKey(globalSettings);
        break;

      ///保存主题类型
      case GSKey.themeType:
        debugPrint('setKeyValue:value:$value');
        GSMap.map[GSKey.themeType]!.value = value;
        GlobalSettings globalSettings = await getThemeType();
        // _setTheme(value, GSMap.map[GSKey.themeColor]!.value);
        Provider.of<ThemeNotifier>(Get.context!, listen: false).setThemeAll();
        globalSettings.value = value;
        _setKey(globalSettings);
        break;

      ///保存主题类型
      case GSKey.themeColor:
        //设置颜色值
        GSMap.map[GSKey.themeColor]!.value = value;
        //根据主题设置颜色 暗黑主题无法设置颜色
        // _setTheme(GSMap.map[GSKey.themeType]!.value, value);
        Provider.of<ThemeNotifier>(Get.context!, listen: false).setThemeAll();
        GlobalSettings globalSettings = await getThemeColor();
        globalSettings.value = value;
        _setKey(globalSettings);
        break;

      ///保存初始化状态
      case GSKey.initData:
        //设置初始化状态
        GSMap.map[GSKey.initData]!.value = value;
        //根据主题设置颜色 暗黑主题无法设置颜色
        GlobalSettings globalSettings = await getInitData();
        globalSettings.value = value;
        _setKey(globalSettings);
        break;

      ///默认方法
      default:
        debugPrint('setKeyValue');
        break;
    }
  }

  ///获取主题设置相关信息
  Future<GlobalSettings> getThemeColor() async {
    final GlobalSettings? globalSettings = await _getKey(GSKey.themeColor);
    //设置当前主题颜色状态
    if (globalSettings != null) {
      return globalSettings;
    } else {
      GlobalSettings gs =
          GlobalSettings(GSKey.themeColor, Colors.green.value.toString());
      await _setKey(gs);
      return gs;
    }
  }

  ///获取主题设置相关信息
  Future<GlobalSettings> getThemeType() async {
    final GlobalSettings? globalSettings = await _getKey(GSKey.themeType);
    //设置当前主题状态

    if (globalSettings != null) {
      return globalSettings;
    } else {
      GlobalSettings gs = GlobalSettings(GSKey.themeType, ThemeType.auto);
      await _setKey(gs);
      return gs;
    }
  }

  ///获取语言设置相关信息
  Future<GlobalSettings> getLanguageType() async {
    final GlobalSettings? globalSettings = await _getKey(GSKey.languageType);
    //设置当前语言状态

    if (globalSettings != null) {
      return globalSettings;
    } else {
      GlobalSettings gs = GlobalSettings(GSKey.languageType, LanguageType.auto);
      await _setKey(gs);
      return gs;
    }
  }

  ///获取初始化相关配置
  Future<GlobalSettings> getInitData() async {
    final GlobalSettings? globalSettings = await _getKey(GSKey.initData);
    //设置当前语言状态
    if (globalSettings != null) {
      return globalSettings;
    } else {
      GlobalSettings gs =
          GlobalSettings(GSKey.initData, DefaultStaticData.initTrue);
      await _setKey(gs);
      return gs;
    }
  }

  ///设置全局键值
  Future<int> _setKey(GlobalSettings globalSettings) {
    Isar isar = IsarDbUtils.getIsarInstance;
    return isar.writeTxn(() {
      //设置键
      return isar.globalSettings.put(globalSettings);
    });
  }

  ///获取语言类型
  Future<GlobalSettings?> _getKey(String key) {
    Isar isar = IsarDbUtils.getIsarInstance;
    return isar.writeTxn(() {
      //查询键
      return isar.globalSettings.filter().keyEqualTo(key).findFirst();
    });
  }
}
