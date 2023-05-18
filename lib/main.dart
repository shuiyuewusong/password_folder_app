import 'package:password_folder_app/data/app_data.dart';
import 'package:password_folder_app/data/folder_data.dart';
import 'package:password_folder_app/data/password_data.dart';
import 'package:password_folder_app/data/theme_notifier.dart';
import 'package:password_folder_app/i18n/language_localizations.dart';
import 'package:password_folder_app/i18n/language_type.dart';
import 'package:password_folder_app/init/init.dart';
import 'package:password_folder_app/page/app_settings.dart';
import 'package:password_folder_app/page/folder/folder_add.dart';
import 'package:password_folder_app/page/folder/folder_edit.dart';
import 'package:password_folder_app/page/folder/folder_settings.dart';
import 'package:password_folder_app/page/home_page.dart';
import 'package:password_folder_app/page/login/login_page.dart';
import 'package:password_folder_app/page/password/password_add.dart';
import 'package:password_folder_app/page/password/password_edit.dart';
import 'package:password_folder_app/page/password/password_view.dart';
import 'package:password_folder_app/page/setting/basic_settings.dart';
import 'package:password_folder_app/page/setting/basic_settings/theme_color.dart';
import 'package:password_folder_app/page/setting/manually_sync_settings.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  _initRunApp();
}

void _initRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('A');
  final bo = await initRun();
  debugPrint('B:$bo');
  debugPrint('C');
  debugPrint('D');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppData()),
      ChangeNotifierProvider(create: (context) => FolderData()),
      ChangeNotifierProvider(create: (context) => PasswordData()),
      ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    ],
    child: const MyApp(),
  ));
}

//同步执行

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      //设置主题
      theme: themeNotifier.getThemeDataLight,
      //设置主界面
      darkTheme: themeNotifier.getThemeDataDark,
      // home: const HomePage(),  使用路由而不是home
      // 路由相关设置
      initialRoute: RoutingTable.homePage,

      ///路由表
      routes: {
        // RoutingTable.startPage: (contxt) => const StartPage(),
        RoutingTable.homePage: (contxt) {
          return const HomePage();
        },
        RoutingTable.appSetting: (contxt) => const AppSettingPage(),
        RoutingTable.basicSetting: (contxt) => const BasicSettingPage(),
        RoutingTable.themeSetting: (contxt) => const ThemeColorPage(),
        RoutingTable.folderSetting: (contxt) => const FolderSettingPage(),
        RoutingTable.folderAdd: (contxt) => const FolderAddPage(),
        RoutingTable.folderEdit: (contxt) => const FolderEditPage(),
        RoutingTable.passwordAdd: (contxt) => const PasswordAddPage(),
        RoutingTable.passwordEdit: (contxt) => const PasswordEditPage(),
        RoutingTable.passwordView: (contxt) => const PasswordViewPage(),
        RoutingTable.manuallySyncSettings: (contxt) =>
            const ManuallySyncSettingsPage(),

        ///登录页
        RoutingTable.login: (contxt) => const LoginPage(),
      },
      // onGenerateRoute: onGenerateRoute,
      //国际化相关设置
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
        GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
        GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
      ],
      //支持区域设置
      supportedLocales: const [
        Locale(LanguageType.en),
        Locale(LanguageType.zh),
      ],
      //动态语言加载项
      translations: MyLanguageTr(),
      //当前区域设置
      locale: Get.deviceLocale,
      //默认回退 区域设置
      fallbackLocale: const Locale(LanguageType.zh, LanguageType.cn),
    );
  }
}
