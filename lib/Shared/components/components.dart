import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Modules/login_screen/login_screen.dart';
import 'package:shop_app/Shared/network/local/cached_data.dart';
import 'package:shop_app/Shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void navigatTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigatAndFinish(context, screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Widget defaultTextField(
    {control,
    focus,
    hint,
    preIcon,
    sfxIcon,
    secure = false,
    validate,
    keyboard = TextInputType.text,
    onSubmit}) {
  return TextFormField(
    focusNode: focus,
    onFieldSubmitted: onSubmit,
    keyboardType: keyboard,
    validator: validate,
    obscureText: secure,
    cursorColor: defaultColor,
    controller: control,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: defaultColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      hintText: hint,
      prefixIcon: preIcon,
      prefixIconColor: defaultColor,
      suffixIcon: sfxIcon,
      suffixIconColor: defaultColor,
    ),
  );
}

Widget defaultButton({required child, double width = double.infinity,double ?height, onClick}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: onClick ?? () {},
      style: ButtonStyle(overlayColor: MaterialStatePropertyAll(defaultColor)),
      child: child,
    ),
  );
}

Future showToast({required ToastState state, required String? message}) async {
  return await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { success, warning, error }

Color? toastColor(state) {
  switch (state) {
    case ToastState.success:
      return Colors.lightGreen;
    case ToastState.warning:
      return Colors.amber;
    case ToastState.error:
      return defaultColor;
  }
  return null;
}

void signOut(context){
  UserCached.removeData("token")
      .then((value) => navigatAndFinish(context, LogInScreen()))
      .catchError((onError) {
    print(onError.toString());
  });
}
Widget showIndicator({controller,length,onDot}){
  return  SmoothPageIndicator(
      controller: controller,
      count: length,
      onDotClicked: (i) {
        controller.animateToPage(i,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut);
      },
      effect: WormEffect(
          type: WormType.thin,
          activeDotColor: defaultColor,
          dotColor: Colors.black12,
          dotHeight: 10,
          dotWidth: 25,
          spacing: 20));
}