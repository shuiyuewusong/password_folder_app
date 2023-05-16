import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/data/folder_data.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingFolderWidget extends StatefulWidget {
  const SettingFolderWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SettingFolderWidgetState();
}

// class _CMyTitleWidgetState extends State<CMyTitleWidget> {
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('get title build');
//     return Text(
//       '${context.watch<CMyModel>().val}',
//     );
//   }
// }
class _SettingFolderWidgetState extends State<SettingFolderWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint('get 设置 密码夹 列表 build');
    return Selector<FolderData, List<FolderBean>>(
      // _ 表示不使用这个参数
      selector: (_, folderModel) => folderModel.getFolderList,
      builder: (_, folderModel, child) {
        debugPrint('get 设置 密码夹 列表 build.builder');
        return ListView(
          children: _folderList(context, folderModel),
        );
      },
    );
  }
}

List<ListTile> _folderList(
    BuildContext context, List<FolderBean> folderBeanList) {
  List<ListTile> list = [];
  for (FolderBean folderBean in folderBeanList) {
    list.add(_folderTile(context, folderBean));
  }
  return list;
}

ListTile _folderTile(BuildContext context, FolderBean folderBean) {
  return ListTile(
    title: Text(
      folderBean.name,
    ),
    subtitle: Text(folderBean.notes),
    // leading: const Icon(Icons.key),
    trailing: IconButton(
      icon: const Icon(
        Icons.edit,
      ),
      onPressed: () {
        //编辑事件触发
        Navigator.pushNamed(context, RoutingTable.folderEdit,
            arguments: {FolderBean.beanFolder: folderBean}).then((value) {
          FolderService().refreshFolderList(context);
        });
      },
    ),
    // 点击事件回调
    onTap: () {
      // Navigator.of(context);
      // printTest(id);
    },
  );
}
