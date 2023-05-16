import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/login/widget/code_input_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  ///新增密码夹页
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController(text: '');
  String _code = '';
  var _length = 6; //验证码长度，输入框框的个数
  var _type = CodeInputType.squareBox;
  double _sliderProcess = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.titleCreate.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.password,
                size: 100,
              ),
            ),
            Stack(
              children: <Widget>[
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InputCell(isFocused: _code.length == 0, text: _code.length>=1?_code.substring(0,1):''),
                    InputCell(isFocused: _code.length == 1, text: _code.length>=2?_code.substring(1,2):''),
                    InputCell(isFocused: _code.length == 2, text: _code.length>=3?_code.substring(2,3):''),
                    InputCell(isFocused: _code.length == 3, text: _code.length>=4?_code.substring(3,4):''),
                    InputCell(isFocused: _code.length == 4, text: _code.length>=5?_code.substring(4,5):''),
                    InputCell(isFocused: _code.length == 5, text: _code.length>=6?_code.substring(5,6):'',),
                  ],
                )*/

                ///[CodeInputRow]其实就是上面这段注释的代码里的Row封装一下
                //验证码输入框整行，
                CodeInputRow(code: _code, length: _length, type: _type),
                Opacity(
                  opacity: 0,
                  child: TextField(
                    //只能输入字母与数字
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z,0-9,A-Z]"))
                    ],
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    onChanged: (String str) {
                      _code = str;
                      setState(() {});
                      if (str.length == _length) {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('填入的验证码是$_code'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((v) {
                          _controller.text = '';
                          _code = '';
                          setState(() {});
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    ///清理所有输入参数
  }
}
