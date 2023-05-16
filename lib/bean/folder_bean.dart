import 'package:isar/isar.dart';

/// 如果类有更新需要使用代码生成器重新生成:flutter pub run build_runner build
part 'folder_bean.g.dart';

@collection
class FolderBean {
  ///主键 1
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的
  ///名称 2
  late String name;

  ///排序 3
  late int orders;

  ///备注 4
  late String notes;

  ///静态变量
  static const String beanFolder = 'folderBean';
  static const String _folderId = 'id';
  static const String _folderName = 'name';
  static const String _folderOrders = 'orders';
  static const String _folderNotes = 'notes';

  FolderBean() {
    name = '';
    orders = 0;
    notes = '';
  }

  clone(FolderBean folderBean) {
    FolderBean f = FolderBean();
    f.id = folderBean.id;
    f.name = folderBean.name;
    f.orders = folderBean.orders;
    f.notes = folderBean.notes;
    return f;
  }

  Map<String, dynamic> getMap() {
    return {
      _folderId: id,
      _folderName: name,
      _folderOrders: orders,
      _folderNotes: notes,
    };
  }

  setMap(Map<String, dynamic> map) {
    id = map[_folderId];
    name = map[_folderName];
    orders = map[_folderOrders];
    notes = map[_folderNotes];
  }
}
