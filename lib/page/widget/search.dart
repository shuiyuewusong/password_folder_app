import 'package:password_folder_app/page/widget/home_password_list.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';

//实现搜索类
class SearchBarDelegate extends SearchDelegate<String> {
  //右侧显示搜索按钮
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      ///搜索按钮
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          debugPrint('query:$query');
          PasswordService().refreshListOfName(context, query);
          //触发搜索事件
          showResults(context);
        },
      ),

      ///清空按钮
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // 如果有内容则清空内容如果无内容返回
          if (query.isNotEmpty) {
            //清空搜索内容
            query = "";
            //触发还原事件
            showSuggestions(context);
          } else {
            //返回上一级
            close(context, "0");
          }
        },
      ),
    ];
  }

  //左侧显示返回按钮
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        //触发关闭事件
        PasswordService().refreshListOfFolder(context);
        FolderService().refreshFolderList(context);
        close(context, "0");
      },
    );
  }

  //展示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return const HomePasswordWidget();
  }

  //当前搜索信息展示
  @override
  Widget buildSuggestions(BuildContext context) {
    debugPrint('query:$query');
    if (query.isNotEmpty) {
      PasswordService().refreshListOfName(context, query);
    } else {
      PasswordService().refreshListOfAll(context);
    }
    return const HomePasswordWidget();
  }
}
