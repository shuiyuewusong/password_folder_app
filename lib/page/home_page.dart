import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/init/init.dart';
import 'package:password_folder_app/page/widget/home_folder_list.dart';
import 'package:password_folder_app/page/widget/home_password_list.dart';
import 'package:password_folder_app/page/widget/search.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  ///主页
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool runInitBool = false;

  // List<FolderBean> _folderList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    refreshData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.title.tr),

        ///顶部左侧按钮
        leading: IconButton(
            onPressed: () {
              //跳转到设置页面,且如果返回到首页则直接刷新当前页面
              Navigator.pushNamed(context, RoutingTable.appSetting)
                  .then((value) {
                PasswordService().refreshListOfFolder(context);
              });
            },
            icon: const Icon(
              Icons.settings,
            )),

        ///顶部右侧按钮
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, RoutingTable.login);
          //     },
          //     icon: const Icon(Icons.refresh)),
          IconButton(
            //搜索按钮
            onPressed: () {
              //显示对话框
              showSearch(
                context: context,
                delegate: SearchBarDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutingTable.passwordAdd)
                  .then((value) {
                PasswordService().refreshListOfFolder(context);
              });
            },
            icon: const Icon(Icons.add),
          )
          // 设置按钮
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   ///新增密码按钮
      //   onPressed: () {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(messageSnackBar("messageText"));
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: const Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 24,
            child: HomeFolderWidget(),
          ),
          Expanded(
            flex: 1,
            child: VerticalDivider(
              width: 1000,
              thickness: 2,
            ),
          ),
          Expanded(
            flex: 75,
            child: HomePasswordWidget(),
          )
        ],
      ),
    );
  }
}