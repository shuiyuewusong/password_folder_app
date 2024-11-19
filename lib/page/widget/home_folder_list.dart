import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/data/data.dart';
import 'package:password_folder_app/data/folder_data.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeFolderWidget extends StatefulWidget {
  // final int onCheckFolderId;
  ///主页密码夹列表
  const HomeFolderWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomeFolderWidgetState();
}

class _HomeFolderWidgetState extends State<HomeFolderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_onTopCheckColor');
    debugPrint('get 主页 密码夹 列表 build');
    return Selector<FolderData, List<FolderBean>>(
      // _ 表示不使用这个参数
      selector: (_, folderData) => folderData.getFolderList,
      builder: (_, folderData, child) {
        // debugPrint('get 主页 密码夹 列表 build.builder');
        return ListView(
          children: _folderList(folderData),
        );
      },
    );
  }

  List<ListTile> _folderList(List<FolderBean> folderBeanList) {
    List<ListTile> list = [];
    FolderBean folderBean = FolderBean();

    folderBean.id = DefaultStaticData.defaultFolderId;

    ///起始页默认分组名称
    folderBean.name = LanguageText.allPassword.tr;
    list.add(_folderTile(folderBean));
    for (FolderBean folderBean in folderBeanList) {
      list.add(_folderTile(folderBean));
    }
    return list;
  }

  ListTile _folderTile(FolderBean folderBean) {
    debugPrint('FolderBean:${folderBean.getMap()}');
    return ListTile(
      // key: ,
      title: Text(
        folderBean.name,
        maxLines: 1,
        style: TextStyle(
          // fontWeight: FontWeight.w900,
          fontSize: 16,
          // color: folderBean.id == DynamicData.onTopCheckFolderId
          //     ? Theme.of(context).primaryColor
          //     : null,
        ),
        // 点击事件回调
      ),
      tileColor: folderBean.id == DynamicData.onTopCheckFolderId
          ? Theme.of(context).colorScheme.primary
          : null,
      // 点击事件回调
      //onFocusChange: ,
      onTap: () {
        onTapCheck(folderBean.id);
      },
      // onLongPress: () {
      //   onTapCheck(folderBean.id);
      // },
    );
  }

  void onTapCheck(int id) {
    setState(() {
      DynamicData.onTopCheckFolderId = id;
      PasswordService().refreshListOfFolder(context);
    });
    // Navigator.of(context);
    debugPrint('onTap$id');
  }
}
