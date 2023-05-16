import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/folder/widget/folder_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderAddPage extends StatefulWidget {
  ///新增密码夹页
  const FolderAddPage({super.key});

  @override
  State<FolderAddPage> createState() => _FolderAddPageState();
}

class _FolderAddPageState extends State<FolderAddPage> {
  final GlobalKey<FolderFormPageState> _globalKey =
      GlobalKey<FolderFormPageState>();
  late FolderBean _folderBean;

  @override
  void initState() {
    super.initState();
    _folderBean = FolderBean();
    //设置初始值
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.titleCreate.tr),
        actions: [
          IconButton(
            onPressed: () {
              _globalKey.currentState!.put();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: FolderFormPage(
        key: _globalKey,
        folderBean: _folderBean,
        isAdd: true,
      ),
    );

    ///清理所有输入参数
  }
}
