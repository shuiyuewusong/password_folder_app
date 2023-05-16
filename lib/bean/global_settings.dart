import 'package:isar/isar.dart';

/// 如果类有更新需要使用代码生成器重新生成:flutter pub run build_runner build
part 'global_settings.g.dart';

@collection
class GlobalSettings {
  ///主键 1
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的
  ///键 2
  String key;

  ///值 3
  String value;

  ///静态变量
  static const String beanGlobalSettings = 'GlobalSettingsBean';
  static const String _id = 'id';
  static const String _key = 'key';
  static const String _value = 'value';

  GlobalSettings(this.key, this.value);

  clone(GlobalSettings globalSettings) {
    GlobalSettings gs =
        GlobalSettings(globalSettings.key, globalSettings.value);
    gs.id = globalSettings.id;
    return gs;
  }

  Map<String, dynamic> getMap() {
    return {
      _id: id,
      _key: key,
      _value: value,
    };
  }

  setMap(Map<String, dynamic> map) {
    id = map[_id];
    key = map[_key];
    value = map[_value];
  }
}
