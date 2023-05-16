import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingPage extends StatefulWidget {
  ///APP设置页
  const AppSettingPage({super.key});

  @override
  State<AppSettingPage> createState() => _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.appSettings.tr),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(LanguageText.basicSettings.tr),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutingTable.basicSetting);
            },
            onLongPress: () {
              Navigator.pushNamed(context, RoutingTable.basicSetting);
            },
            // onFocusChange: (){
            //   print(3333);
            // },
          ),
          ListTile(
            title: Text(LanguageText.folderSettings.tr),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutingTable.folderSetting);
            },
            onLongPress: () {
              Navigator.pushNamed(context, RoutingTable.folderSetting);
            },
          ),
          ListTile(
            title: Text(LanguageText.manuallySyncSettings.tr),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutingTable.manuallySyncSettings)
                  .then((value) {
                PasswordService().refreshListOfFolder(context);
              });
            },
            onLongPress: () {
              Navigator.pushNamed(context, RoutingTable.manuallySyncSettings)
                  .then((value) {
                PasswordService().refreshListOfFolder(context);
              });
            },
          ),
          ListTile(
            title: Text(LanguageText.autoSyncSettings.tr),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              print(1111);
            },
            onLongPress: () {
              print(2222);
            },
          ),
        ],
      ),
    );
  }
}
