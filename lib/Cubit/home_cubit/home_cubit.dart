import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Models/change_favorite_model.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Models/home_model.dart';
import 'package:shop_app/Models/login_model.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Modules/categories_screen/categories_screen.dart';
import 'package:shop_app/Modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/Modules/products_screen/products_screen.dart';
import 'package:shop_app/Modules/settings_screen/settings_screen.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/end_points.dart';
import 'package:shop_app/Shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  int bottomNavIndex = 0;
  HomeModel? homeData;
  Map<int, bool> favProducts = {};

  void changeNavBottom(i) {
    bottomNavIndex = i;
    emit(HomeChangeBottomNavState());
  }

  CategoriesModel? categoriesModel;

  LoginModel? loginData;
  bool isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibility());
  }

  void userLogin({required email, required password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginData = LoginModel(value.data);
      emit(LoginSuccessState(loginData));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void getCategoriesData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessGetState());
    }).catchError((onError) {
      print(onError.toString());
      emit(CategoriesErrorGetState(onError.toString()));
    });
  }

  void getHomeData(token) {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeData = HomeModel.fromJson(value.data);
      for (var product in homeData!.data!.products) {
        favProducts.addAll({product.id!: product.inFavorite!});
      }
      emit(HomeSuccessGetState());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeErrorGetState(onError.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavState(int index) {
    favProducts[index] = !favProducts[index]!;
    emit(FavoriteChangeState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': index}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        favProducts[index] = !favProducts[index]!;
        emit(FavoriteSuccessPostState(
            value.data['status'], value.data['message']));
      } else {
        getFavProducts();
        emit(FavoriteSuccessPostState(
            value.data['status'], value.data['message']));
      }
    }).catchError((onError) {
      favProducts[index] = !favProducts[index]!;
      emit(FavoriteErrorPostState(onError.toString()));
    });
    emit(FavoriteChangeState());
  }

  FavoritesModel? favoriteModel;

  void getFavProducts() {
    emit(FavoriteLoadingGetState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoriteModel = FavoritesModel.fromJson(value.data);
      emit(FavoriteSuccessGetState());
    }).catchError((onError) {
      print(onError.toString());
      emit(FavoriteErrorGetState(onError.toString()));
    });
  }

  void logOutState(context) {
    emit(LogOutLoadingState());
    print(token);
    DioHelper.postData(url: LOGOUT, data: {}, token: token).then((value) {
      signOut(context);
      emit(LogOutSuccessState(value.data['status'], value.data['message']));
    }).catchError((onError) {
      print(onError.toString());
      emit(LogOutErrorState(onError));
    });
  }

  LoginModel? userModel;

  void getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      print(value.data);
      userModel = LoginModel(value.data);
      print(userModel!.data!.image);
      emit(GetProfileSuccessState(userModel));

    }).catchError((onError) {
      print(onError.toString());
      emit(GetProfileErrorState(onError.toString()));
    });
  }
SearchModel? searchModel;
  void getSearch(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorState(onError.toString()));
    });
  }
}
