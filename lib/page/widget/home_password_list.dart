import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/data/password_data.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:password_folder_app/page/widget/look_simple_dialog.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePasswordWidget extends StatefulWidget {
  ///主页密码列表
  const HomePasswordWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HomePasswordWidgetState();
}

class _HomePasswordWidgetState extends State<HomePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint('get 主页 密码 列表 build');
    return Selector<PasswordData, List<PasswordBean>>(
      // _ 表示不使用这个参数
      selector: (_, passwordData) => passwordData.getPasswordList,
      builder: (_, passwordData, child) {
        debugPrint('get 主页 密码 列表 build.builder');
        if (passwordData.isEmpty) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: const Text(
              '没有更多了',
              style: TextStyle(color: Colors.grey),
            ),
          );
        } else {
          return ListView(
            children: _passwordList(passwordData),
          );
        }
      },
    );
  }

  List<ListTile> _passwordList(List<PasswordBean> passwordBeanList) {
    List<ListTile> list = [];
    for (PasswordBean passwordBean in passwordBeanList) {
      list.add(_passwordTile(passwordBean));
    }
    return list;
  }

  ListTile _passwordTile(PasswordBean passwordBean) {
    debugPrint('PasswordBean:${passwordBean.getMap()}');
    return ListTile(
      title: Text(
        passwordBean.name,
      ),
      subtitle: Text(passwordBean.notes),
      // leading: const Icon(Icons.key),
      trailing: IconButton(
        icon: const Icon(
          Icons.key,
        ),
        onPressed: () {
          //弹出账号密码快速复制框

          showDialog(
              context: context,
              builder: (context) {
                return LookSimpleDialog(
                  passwordBean: passwordBean,
                );
              });

          //编辑事件触发
          // Navigator.pushNamed(context, RoutingTable.passwordEdit,
          //         arguments: {PasswordBean.beanPassword: passwordBean})
          //     .then((value) {
          //   PasswordService().refreshListOfFolder(context);
          // });
        },
      ),
      onTap: () {
        Navigator.pushNamed(context, RoutingTable.passwordView,
            arguments: {PasswordBean.beanPassword: passwordBean}).then((value) {
          PasswordService().refreshListOfFolder(context);
        });
        debugPrint("点击事件回调");
      },
      onLongPress: () {
        ///长长按触发将内容复制到剪贴板
        Clipboard.setData(ClipboardData(text: passwordBean.password));
        Get.showSnackbar(
            messageSnackBar(LanguageText.passwordCopiedToClipboard.tr));
        debugPrint("长按事件回调");
      },
    );
  }
}
