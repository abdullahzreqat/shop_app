import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/register_cubit/register_states.dart';
import 'package:shop_app/Models/register_model.dart';
import 'package:shop_app/Shared/network/end_points.dart';
import 'package:shop_app/Shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  RegisterModel? registerModel;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterChangePasswordVisibility());
  }
  void changeConfirmPasswordVisibility(){
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(RegisterConfirmChangePasswordVisibility());
  }

  void userRegister({
    required name,
    required email,
    required password,
    required phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) {
   registerModel=   RegisterModel(value.data);
      print(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }
}
