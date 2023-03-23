import 'package:shop_app/Models/login_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class LoginChangePasswordVisibility extends HomeStates {}

class LoginLoadingState extends HomeStates {}

class LoginSuccessState extends HomeStates {
  LoginModel? loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends HomeStates {
  String error;

  LoginErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessGetState extends HomeStates {}

class HomeErrorGetState extends HomeStates {
  final String onError;

  HomeErrorGetState(this.onError);
}

class CategoriesLoadingState extends HomeStates {}

class CategoriesSuccessGetState extends HomeStates {}

class CategoriesErrorGetState extends HomeStates {
  final String onError;

  CategoriesErrorGetState(this.onError);
}class GetProfileSuccessState extends HomeStates {
  LoginModel? userModel;
  GetProfileSuccessState(this.userModel);
}

class GetProfileLoadingState extends HomeStates {}

class GetProfileErrorState extends HomeStates {
  final String onError;

  GetProfileErrorState(this.onError);
}

class LogOutLoadingState extends HomeStates {}

class LogOutSuccessState extends HomeStates {
  final bool status;
  final String message;

  LogOutSuccessState(this.status, this.message);
}

class LogOutErrorState extends HomeStates {
  final String onError;

  LogOutErrorState(this.onError);
}

class FavoriteChangeState extends HomeStates {}

class FavoriteLoadingState extends HomeStates {}

class FavoriteSuccessGetState extends HomeStates {}

class FavoriteLoadingGetState extends HomeStates {}

class FavoriteSuccessPostState extends HomeStates {
  final bool status;
  final String message;

  FavoriteSuccessPostState(this.status, this.message);
}

class FavoriteErrorPostState extends HomeStates {
  final String onError;

  FavoriteErrorPostState(this.onError);
}

class FavoriteErrorGetState extends HomeStates {
  final String onError;

  FavoriteErrorGetState(this.onError);
}
class SearchLoadingState extends HomeStates {}
class SearchSuccessState extends HomeStates {}
class SearchErrorState extends HomeStates {
  final String onError;

  SearchErrorState(this.onError);
}