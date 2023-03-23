// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/bloc_observer.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Layouts/home_layout.dart';
import 'package:shop_app/Modules/login_screen/login_screen.dart';
import 'package:shop_app/Modules/onboard_screen/onboard_screen.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/local/cached_data.dart';
import 'package:shop_app/Shared/network/remote/dio_helper.dart';
import 'package:shop_app/Shared/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await UserCached.init();
  bool? onBoarding = UserCached.getData("onBoarding");
  token = UserCached.getData('token');

  Widget widget = OnBoardScreen();
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LogInScreen();
    }
  } else {
    widget = OnBoardScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData(token)
        ..getCategoriesData()
        ..getFavProducts()
        ..getProfile(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          theme: lightTheme(context),
          debugShowCheckedModeBanner: false,
          title: "Shop App",
          home: startWidget,
        ),
      ),
    );
  }
}
