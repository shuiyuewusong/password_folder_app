import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/dao/isar_db_utils.dart';
import 'package:password_folder_app/data/folder_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

///密码夹 增删改查服务
class FolderService {
  static final FolderService _folderService = FolderService._init();

  FolderService._init();

  factory FolderService() {
    return _folderService;
  }

  ///加载密码文件夹相关数据
  void refreshFolderList(BuildContext context) {
    debugPrint('getFolderList');
    Isar isar = IsarDbUtils.getIsarInstance;
    Future<List<FolderBean>> future =
        isar.folderBeans.where().sortByOrders().findAll();
    future.then((value) {
      debugPrint("开始更新密码夹数据");
      debugPrint("清空列表");
      Provider.of<FolderData>(context, listen: false).update([]);
      debugPrint("重新赋值");
      Provider.of<FolderData>(context, listen: false).update(value);
    });
  }

  ///获取列表
  List<FolderBean> getFolderList(BuildContext context) {
    return Provider.of<FolderData>(context, listen: false).getFolderList;
  }

  ///删除密码夹
  Future<bool> delete(FolderBean folderBean) async {
    Isar isar = IsarDbUtils.getIsarInstance;

    final a = await isar.writeTxn(() async {
      //验证密码夹是否包含密码
      final run1 = await isar.passwordBeans
          .filter()
          .folderIdEqualTo(folderBean.id.toString())
          .findAll();
      debugPrint("value.run1:${run1.length.toString()}");
      return run1;
    });
    debugPrint("value.a:${a.length.toString()}");
    if (a.isNotEmpty) {
      return false;
    } else {
      //无密码进行删除
      final b = await isar.writeTxn(() async {
        final run2 = await isar.folderBeans.delete(folderBean.id);
        debugPrint("value.run2:${run2.toString()}");
        return run2;
      });
      debugPrint("value.b:${b.toString()}");
      return true;
    }
  }

  Future<int> add(FolderBean folderBean) {
    Isar isar = IsarDbUtils.getIsarInstance;
    return isar.writeTxn(() {
      return isar.folderBeans.put(folderBean);
    });
  }

  ///更新全部数据,将原有数据删除并新增导入数据
  Future updateAll(List<FolderBean> list) async {
    Isar isar = IsarDbUtils.getIsarInstance;
    final writeTxn = await isar.writeTxn(() async {
      final del = await isar.folderBeans.filter().nameIsNotEmpty().deleteAll();
      debugPrint("updateAll.del:${del.toString()}");
      final addAll = await isar.folderBeans.putAll(list);
      debugPrint("updateAll.addAll:${addAll.toString()}");
      return addAll;
    });
    return writeTxn;
  }
}
