import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/cupertino.dart';

///初始化方法
Future<bool> initRun() async {
  debugPrint("initRun-initRun");
  debugPrint("开始加载Isar数据库");
  final bool b = await IsarDbUtils.getIsar.init();
  if (b) {
    debugPrint("init-${b.toString()}");
    debugPrint("加载结束");
    debugPrint("开始加载全局静态数据");

    return await GlobalSettingsService().init();
  } else {
    return false;
  }
}

///刷新基础数据
void refreshData(BuildContext context) {
  //加载密码夹相关列表
  debugPrint("开始加载密码夹数据");
  FolderService().refreshFolderList(context);
  debugPrint("开始加载密码数据");
  PasswordService().refreshListOfFolder(context);
}
