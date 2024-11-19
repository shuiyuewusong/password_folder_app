import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/data/data.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/cupertino.dart';

var logger = Logger();

///初始化方法
Future<bool> initRun() async {
  logger.i("initRun-initRun");
  logger.i("开始加载Isar数据库");
  final bool b = await IsarDbUtils.getIsar.init();
  if (b) {
    logger.i("init-${b.toString()}");
    logger.i("加载结束");
    logger.i("开始加载全局静态数据");

    return await GlobalSettingsService().init();
  } else {
    return false;
  }
}

///刷新基础数据
void refreshData(BuildContext context) {
  //加载密码夹相关列表
  logger.i("开始加载密码夹数据");
  FolderService().refreshFolderList(context);
  logger.i("开始加载密码数据");
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
  logger.i(p);
  GlobalSettingsService()
      .setKeyValue(GSKey.initData, DefaultStaticData.initFalse);
  FolderService().refreshFolderList(Get.context!);
  PasswordService().refreshListOfFolder(Get.context!);
}
