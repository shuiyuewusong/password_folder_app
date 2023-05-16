import 'package:password_folder_app/data/theme.dart';
import 'package:password_folder_app/service/global_settings_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeColorPage extends StatefulWidget {
  ///新增密码夹页
  const ThemeColorPage({super.key});

  @override
  State<ThemeColorPage> createState() => _ThemeColorPageState();
}

class _ThemeColorPageState extends State<ThemeColorPage> {
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;

  // Color for the picker in a dialog using onChanged.
  // late Color dialogPickerColor;

  // Color for picker using the color select dialog.
  // late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor =
        Color(int.parse(GSMap.map[GSKey.themeColor]!.value)); // Material blue.
    // dialogPickerColor = Colors.red; // Material red.
    // dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('主题颜色选择器'),
        actions: [
          IconButton(
            onPressed: () {
              //恢复默认颜色
              setState(() {
                screenPickerColor = Color(int.parse(ThemeColor.def));
                GlobalSettingsService()
                    .setKeyValue(GSKey.themeColor, ThemeColor.def);
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
            onPressed: () {
              //设置颜色
              setState(() {
                GlobalSettingsService().setKeyValue(
                    GSKey.themeColor, screenPickerColor.value.toString());
                Get.back();
              });
            },
            icon: const Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        children: <Widget>[
          ListTile(
            title: const Text('选择下面的颜色以更改主题色,点击右上角进行恢复初始颜色和保存,暗黑主题设置颜色无法生效.'),
            // subtitle: Text('${ColorTools.primarySwatch(screenPickerColor)} '
            //     'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
            trailing: ColorIndicator(
              color: Color(screenPickerColor.value),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  color: screenPickerColor,
                  onColorChanged: (Color color) =>
                      setState(() => screenPickerColor = color),
                  pickerTypeLabels: const <ColorPickerType, String>{
                    ColorPickerType.primary: '主色调',
                    ColorPickerType.accent: '强调色',
                  },
                  heading: Text(
                    '选择颜色',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subheading: Text(
                    '选择颜色阴影',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
