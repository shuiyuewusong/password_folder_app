import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/data/data.dart';
import 'package:password_folder_app/data/password_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

///密码增删改查服务
class PasswordService {
  static final PasswordService _passwordService = PasswordService._init();

  PasswordService._init();

  factory PasswordService() {
    return _passwordService;
  }

  ///加载密码相关数据
  void refreshListOfAll(BuildContext context) {
    debugPrint('getPasswordList');
    Isar isar = IsarDbUtils.getIsarInstance;
    Future<List<PasswordBean>> future =
        isar.passwordBeans.where().sortByOrders().findAll();
    future.then((value) {
      debugPrint("开始更新密码数据");
      debugPrint("清空列表");
      Provider.of<PasswordData>(context, listen: false).update([]);
      debugPrint("重新赋值");
      Provider.of<PasswordData>(context, listen: false).update(value);
    });
  }

  ///根据密码册查询相关列表
  void refreshListOfFolder(BuildContext context) {
    if (DynamicData.onTopCheckFolderId == DefaultStaticData.defaultFolderId) {
      refreshListOfAll(context);
    } else {
      debugPrint('refreshPasswordListOfFolder');
      Isar isar = IsarDbUtils.getIsarInstance;
      Future<List<PasswordBean>> future = isar.passwordBeans
          .filter()
          .folderIdEqualTo(DynamicData.onTopCheckFolderId.toString())
          .sortByOrders()
          .findAll();
      future.then((value) {
        debugPrint("开始更新密码数据");
        debugPrint("清空列表");
        Provider.of<PasswordData>(context, listen: false).update([]);
        debugPrint("重新赋值");
        Provider.of<PasswordData>(context, listen: false).update(value);
      });
    }
  }

  ///根据名称查询相关列表
  void refreshListOfName(BuildContext context, String value) {
    debugPrint('refreshPasswordListOfName');
    Isar isar = IsarDbUtils.getIsarInstance;
    Future<List<PasswordBean>> future = isar.passwordBeans
        .filter()
        .nameContains(value)
        .or()
        .accountContains(value)
        .or()
        .notesContains(value)
        .or()
        .emailContains(value)
        .or()
        .networkAddressContains(value)
        .sortByOrders()
        .findAll();
    future.then((value) {
      debugPrint("开始更新密码数据");
      debugPrint("清空列表");
      Provider.of<PasswordData>(context, listen: false).update([]);
      debugPrint("重新赋值");
      Provider.of<PasswordData>(context, listen: false).update(value);
    });
  }

  Future<bool> delete(PasswordBean passwordBean) {
    Isar isar = IsarDbUtils.getIsarInstance;
    return isar.writeTxn(() {
      final run = isar.passwordBeans.delete(passwordBean.id);
      return run;
    });
  }

  Future<int> add(PasswordBean passwordBean) {
    Isar isar = IsarDbUtils.getIsarInstance;
    return isar.writeTxn(() {
      return isar.passwordBeans.put(passwordBean);
    });
  }

  ///更新全部数据,将原有数据删除并新增导入数据
  Future updateAll(List<PasswordBean> list) async {
    Isar isar = IsarDbUtils.getIsarInstance;
    final writeTxn = await isar.writeTxn(() async {
      final del =
          await isar.passwordBeans.filter().nameIsNotEmpty().deleteAll();
      debugPrint("updateAll.del:${del.toString()}");
      final addAll = await isar.passwordBeans.putAll(list);
      debugPrint("updateAll.addAll:${addAll.toString()}");
      return addAll;
    });
    return writeTxn;
  }
}
