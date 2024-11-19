import 'package:password_folder_app/data/theme.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/i18n/language_type.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicSettingPage extends StatefulWidget {
  ///基础设置页
  const BasicSettingPage({super.key});

  @override
  State<BasicSettingPage> createState() => _BasicSettingPageState();
}

class _BasicSettingPageState extends State<BasicSettingPage> {
  ///语言设置下拉菜单
  final GlobalKey<FormFieldState> _languageSettingDropdownGlobalKey =
      GlobalKey<FormFieldState>();

  ///主题设置下拉菜单
  final GlobalKey<FormFieldState> _themeSettingDropdownGlobalKey =
      GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.basicSettings.tr),
      ),
      body: ListView(
        children: [
          ///主题设置
          ListTile(
            title: Text(LanguageText.languageSettings.tr),
            trailing: _themeSettingDropdownButton(),
            onTap: () {
              debugPrint('1111');
            },
            onLongPress: () {
              debugPrint('2222');
            },
          ),

          ///主题色设置
          ListTile(
            title: Text(LanguageText.themeColorSettings.tr),
            trailing: ColorIndicator(
              color: Color(int.parse(GSMap.map[GSKey.themeColor]!.value)),
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutingTable.themeSetting)
                  .then((value) {
                setState(() {});
                //
              });
            },
            onLongPress: () {
              Navigator.pushNamed(context, RoutingTable.themeSetting)
                  .then((value) {
                setState(() {});
                //
              });
            },
            // onFocusChange: (){
            //   print(3333);
            // },
          ),

          ///语言设置
          ListTile(
            title: Text(LanguageText.languageSettings.tr),
            trailing: _languageSettingDropdownButton(),
            onTap: () {
              debugPrint('1111');
            },
            onLongPress: () {
              debugPrint('2222');
            },
          ),

          // ListTile(
          //   title: Text(LanguageText.themeSettings.tr),
          //   trailing: Switch(
          //     value: true,
          //     onChanged: (value) {
          //       debugPrint(value.toString());
          //     },
          //   ),
          //   onTap: () {
          //     debugPrint('1111');
          //   },
          //   onLongPress: () {
          //     debugPrint('2222');
          //   },
          //   // onFocusChange: (){
          //   //   print(3333);
          //   // },
          // ),
        ],
      ),
    );
  }

  ///语言设置选择框
  DropdownButton _languageSettingDropdownButton() {
    return DropdownButton(
      key: _languageSettingDropdownGlobalKey,
      value: GSMap.map[GSKey.languageType]!.value,
      items: [
        DropdownMenuItem(
          value: LanguageType.auto,
          child: Text(LanguageText.automaticAcquisition.tr),
        ),
        DropdownMenuItem(
          value: LanguageType.en,
          child: Text(LanguageText.english.tr),
        ),
        DropdownMenuItem(
          value: LanguageType.zh,
          child: Text(LanguageText.chinese.tr),
        )
      ],
      //根据条件禁用选择
      onChanged: (value) {
        debugPrint('GlobalSettingsService: $value');
        setState(() {
          GlobalSettingsService().setKeyValue(GSKey.languageType, value);
        });
        // _passwordBean.folderId = value;
      },
      // isExpanded: true,
    );
  }

  ///主题设置选择框
  DropdownButton _themeSettingDropdownButton() {
    return DropdownButton(
      key: _themeSettingDropdownGlobalKey,
      value: GSMap.map[GSKey.themeType]!.value,
      items: [
        DropdownMenuItem(
          value: ThemeType.auto,
          child: Text(LanguageText.autoTheme.tr),
        ),
        DropdownMenuItem(
          value: ThemeType.light,
          child: Text(LanguageText.lightTheme.tr),
        ),
        DropdownMenuItem(
          value: ThemeType.dark,
          child: Text(LanguageText.darkTheme.tr),
        )
      ],
      //根据条件禁用选择
      onChanged: (value) {
        debugPrint('GlobalSettingsService:themeType: $value');
        setState(() {
          GlobalSettingsService().setKeyValue(GSKey.themeType, value);
        });
        // _passwordBean.folderId = value;
      },
      // isExpanded: true,
    );
  }
}
