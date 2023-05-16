import 'package:password_folder_app/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///消息提示框
GetSnackBar messageSnackBar(String messageText, {int milliseconds = 3000}) {
  return GetSnackBar(
    title: LanguageText.message.tr,
    message: messageText,
    icon: const Icon(Icons.message),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
    borderRadius: 15,
    shouldIconPulse: false,
    backgroundColor: Theme.of(Get.context!).primaryColor,
    duration: Duration(milliseconds: milliseconds),
    isDismissible: true,
    dismissDirection: DismissDirection.vertical,
  );
}
//序列号	字段	属性	描述
//1	title	String	弹出的标题文字
//2	message	String	弹出的消息文字
//3	colorText	Color	title和message的文字颜色
//4	duration	Duration	Snackbar弹出的持续时间（默认3秒）
//5	instantInit	bool	当false可以把snackbar 放在initState，默认true
//6	snackPosition	SnackPosition	弹出时的位置，有两个选项【TOP，BOTTOM】默认TOP
//7	titleText	Widget	弹出标题的组件，设置该属性会导致title属性失效
//8	messageText	Widget	弹出消息的组件，设置该属性会导致messageText属性失效
//9	icon	Widget	弹出时图标，显示在title和message的左侧
//10	shouldIconPulse	bool	弹出时图标是否闪烁，默认false
//11	maxWidth	double	Snackbar最大的宽度
//12	margin	EdgeInsets	Snackbar外边距，默认zero
//13	padding	EdgeInsets	Snackbar内边距，默认EdgeInsets.all(16)
//14	borderRadius	double	边框圆角大小，默认15
//15	borderColor	Color	边框的颜色，必须设置borderWidth，否则无效果
//16	borderWidth	double	边框的线条宽度
//17	backgroundColor	Color	Snackbar背景颜色，默认Colors.grey.withOpacity(0.2)
//18	leftBarIndicatorColor	Color	左侧指示器的颜色
//19	boxShadows	List	Snackbar阴影颜色
//20	backgroundGradient	Gradient	背景的线性颜色
//21	mainButton	TextButton	主要按钮，一般显示发送、确认按钮
//22	onTap	OnTap	点击Snackbar事件回调
//23	isDismissible	bool	是否开启Snackbar手势关闭，可配合dismissDirection使用
//24	showProgressIndicator	bool	是否显示进度条指示器，默认false
//25	dismissDirection	SnackDismissDirection	Snackbar关闭的方向
//26	progressIndicatorController	AnimationController	进度条指示器的动画控制器
//27	progressIndicatorBackgroundColor	Color	进度条指示器的背景颜色
//28	progressIndicatorValueColor	Animation	进度条指示器的背景颜色，Animation
//29	snackStyle	SnackStyle	Snackbar是否会附加到屏幕边缘
//30	forwardAnimationCurve	Curve	Snackbar弹出的动画，默认Curves.easeOutCirc
//31	reverseAnimationCurve	Curve	Snackbar消失的动画，默认Curves.easeOutCirc
//32	animationDuration	Duration	Snackbar弹出和小时的动画时长，默认1秒
//33	barBlur	double	Snackbar背景的模糊度
//34	overlayBlur	double	弹出时的毛玻璃效果值，默认0
//35	snackbarStatus	SnackbarStatusCallback	Snackbar弹出或消失时的事件回调（即将打开、已打开、即将关闭、已关闭）
//36	overlayColor	Color	弹出时的毛玻璃的背景颜色
//37	userInputForm	Form	用户输入表单
