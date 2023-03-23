import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/Shared/styles/colors.dart';

ThemeData lightTheme(context) => ThemeData(
      iconTheme: IconThemeData(
        color: defaultColor,
        size: 22,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: defaultColor),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepOrange,
      ),
      fontFamily: "OpenSans",
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor,
      ),
      textTheme: TextTheme(
          headlineMedium: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),
          titleLarge: TextStyle(
            color: Colors.grey,
          )),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: defaultColor),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontFamily: "Dancing", color: defaultColor),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark)),
      scaffoldBackgroundColor: Colors.white,
    );
