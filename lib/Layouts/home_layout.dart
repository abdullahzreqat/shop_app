import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Modules/search_screen/search_screen.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(token)..getCategoriesData()..getFavProducts()..getProfile(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.bottomNavIndex,
              onTap: (i) {
                cubit.changeNavBottom(i);
              },
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    navigatTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  padding: EdgeInsetsDirectional.only(end: 25),
                )
              ],
              title: Text(cubit.bottomItems[cubit.bottomNavIndex].label!),
            ),
            body: cubit.screens[cubit.bottomNavIndex],
          );
        },
      ),
    );
  }
}
