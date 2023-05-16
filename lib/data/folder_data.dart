import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:flutter/cupertino.dart';

class FolderData extends ChangeNotifier {
  late List<FolderBean> _folderList;

  List<FolderBean> get getFolderList {
    return _folderList;
  }

  // static List<FolderBean> get getStaticFolderList {
  //   return _folderList;
  // }

  FolderData() {
    _folderList = [];
    debugPrint('FolderData:new');
  }

  void update(List<FolderBean> folderList) {
    debugPrint('FolderData:update _folderList ${_folderList.length}');
    debugPrint('FolderData:update folderList ${folderList.length}');
    _folderList = folderList;
    debugPrint('FolderData:update data');
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('FolderData:disposed');
  }
}
