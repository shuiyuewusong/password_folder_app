import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/folder/widget/folder_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderEditPage extends StatefulWidget {
  // final Map arguments;

  ///编辑密码夹页
  const FolderEditPage({super.key});

  @override
  State<FolderEditPage> createState() => _FolderEditPageState();
}

class _FolderEditPageState extends State<FolderEditPage> {
  final GlobalKey<FolderFormPageState> _globalKey =
      GlobalKey<FolderFormPageState>();

  late FolderBean _folderBean;

  @override
  void initState() {
    super.initState();
    //获取传入的信息
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    _folderBean = arguments[FolderBean.beanFolder];
    return Scaffold(
        appBar: AppBar(
          title: Text(LanguageText.titleEdit.tr),
          actions: [
            // 清理按钮将数据恢复成初始状态
            IconButton(
              onPressed: () {
                debugPrint('_globalKey');
                _globalKey.currentState!.put();
              },
              icon: const Icon(Icons.save),
            ),
            //删除按钮
            IconButton(
              onPressed: () {
                _globalKey.currentState!.delete();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: FolderFormPage(
          key: _globalKey,
          folderBean: _folderBean,
          isAdd: false,
        ));
  }
}
