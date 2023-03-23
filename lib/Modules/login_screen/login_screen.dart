// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Layouts/home_layout.dart';
import 'package:shop_app/Modules/register_screen/register_screen.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/network/local/cached_data.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class LogInScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel?.status == true) {
              showToast(
                  state: ToastState.success,
                  message: state.loginModel?.message);
              UserCached.setData(
                      key: "token", value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                navigatAndFinish(context, HomeLayout());
              }).catchError((error) {
                print(error.toString());
              });
            } else {
              showToast(
                  state: ToastState.error, message: state.loginModel?.message);
            }
          }
        },
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                titleSpacing: 20,
                title: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "SHOP APP",
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("LOG IN",
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: 20),
                      defaultTextField(
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return "Email is Empty!";
                            } else if (!checkValid(value)) {
                              return "Email Not Valid!";
                            }
                          },
                          onSubmit: (_) {
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                          control: emailController,
                          preIcon: Icon(Icons.email_outlined),
                          hint: "Email Address",
                          keyboard: TextInputType.emailAddress),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextField(
                        validate: (value) {
                          if (value.toString().isEmpty) {
                            return "Password is Empty!";
                          } else if (value.toString().length < 6) {
                            return "Password must contain at least 6 characters!";
                          }
                        },
                        onSubmit: (_) {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        focus: passwordFocus,
                        control: passwordController,
                        hint: "Password",
                        sfxIcon: IconButton(
                          onPressed: () {
                            HomeCubit.get(context).changePasswordVisibility();
                          },
                          icon: HomeCubit.get(context).isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          splashRadius: 15,
                        ),
                        preIcon: Icon(Icons.lock_outline),
                        secure: HomeCubit.get(context).isPasswordVisible
                            ? false
                            : true,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      state is! LoginLoadingState
                          ? defaultButton(
                              child: Text("LOG IN"),
                              onClick: () {
                                if (formKey.currentState!.validate()) {
                                  passwordFocus.unfocus();
                                  HomeCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              })
                          : Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You didn't have an account?"),
                          TextButton(
                              onPressed: () {
                                navigatTo(context, RegisterScreen());
                              },
                              child: Text(
                                "REGISTER",
                                style: TextStyle(color: defaultColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
