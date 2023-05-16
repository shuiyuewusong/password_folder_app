import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/folder/widget/setting_folder_list.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderSettingPage extends StatefulWidget {
  ///密码夹设置页
  const FolderSettingPage({super.key});

  @override
  State<FolderSettingPage> createState() => _FolderSettingPageState();
}

class _FolderSettingPageState extends State<FolderSettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.folderSettings.tr),
        actions: [
          //新增密码夹按钮
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, folderAdd);
              Navigator.pushNamed(context, RoutingTable.folderAdd)
                  .then((value) {
                FolderService().refreshFolderList(context);
              });
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: const SettingFolderWidget(),
    );
  }
}
