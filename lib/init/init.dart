import 'package:get/get.dart';
import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/data/data.dart';
import 'package:password_folder_app/i18n/i18n.dart';
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

///初始化添加一个示例密码夹及密码
void initData() async {
  final int f = await FolderService()
      .add(FolderBean(name: LanguageText.example.tr, orders: 999));
  final int p = await PasswordService().add(PasswordBean(
    name: LanguageText.example.tr,
    folderId: f.toString(),
  ));
  GlobalSettingsService()
      .setKeyValue(GSKey.initData, DefaultStaticData.initFalse);
  FolderService().refreshFolderList(Get.context!);
  PasswordService().refreshListOfFolder(Get.context!);
}
