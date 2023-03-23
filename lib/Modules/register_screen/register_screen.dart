// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/Cubit/register_cubit/register_states.dart';
import 'package:shop_app/Modules/login_screen/login_screen.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel?.status == false) {
              showToast(
                  state: ToastState.error,
                  message: state.registerModel?.message);
            }else{
              showToast(
                  state: ToastState.success,
                  message: state.registerModel?.message);
              navigatAndFinish(context, LogInScreen());

        }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                "SHOP APP",
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey = GlobalKey<FormState>(),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        preIcon: Icon(Icons.person),
                        hint: "Your Name",
                        validate: (value) {
                          if (value.toString().isEmpty) {
                            return "Name field empty!";
                          }
                        },
                        onSubmit: (_) =>
                            FocusScope.of(context).requestFocus(emailFocus),
                        control: nameController),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        onSubmit: (_) =>
                            FocusScope.of(context).requestFocus(passwordFocus),
                        focus: emailFocus,
                        validate: (value) {
                          if (value.toString().isEmpty) {
                            return "Email is Empty!";
                          } else if (!checkValid(value)) {
                            return "Email is not valid!";
                          }
                        },
                        hint: "Email Address",
                        control: emailController,
                        preIcon: Icon(Icons.email_outlined),
                        keyboard: TextInputType.emailAddress),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        focus: passwordFocus,
                        onSubmit: (_) => FocusScope.of(context)
                            .requestFocus(confirmPasswordFocus),
                        hint: "Choose Password",
                        validate: (value) {
                          if (value.toString().isEmpty) {
                            return "Password is Empty";
                          } else if (value.toString().length < 6) {
                            return "Password must be at least 6 character";
                          }
                        },
                        secure: cubit.isPasswordVisible ? false : true,
                        control: passwordController,
                        preIcon: Icon(
                          Icons.lock_outline,
                        ),
                        sfxIcon: IconButton(
                            onPressed: () => cubit.changePasswordVisibility(),
                            icon: cubit.isPasswordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        focus: confirmPasswordFocus,
                        onSubmit: (_) =>
                            FocusScope.of(context).requestFocus(phoneFocus),
                        hint: "Confirm Password",
                        validate: (value) {
                          if (passwordController.text != value.toString()) {
                            return "Password doesn't Match!";
                          }
                        },
                        secure: cubit.isConfirmPasswordVisible ? false : true,
                        control: passwordConfirmController,
                        preIcon: Icon(
                          Icons.password_outlined,
                        ),
                        sfxIcon: IconButton(
                            onPressed: () =>
                                cubit.changeConfirmPasswordVisibility(),
                            icon: cubit.isConfirmPasswordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                    SizedBox(
                      height: 10,
                    ),
                    defaultTextField(
                        focus: phoneFocus,
                        keyboard: TextInputType.phone,
                        hint: "Phone Number",
                        control: phoneController,
                        preIcon: Icon(Icons.phone),
                        validate: (value) {
                          if (value.toString().isEmpty) {
                            return "Phone number is empty!";
                          } else if (value
                                  .toString()
                                  .replaceAll(" ", "")
                                  .length !=
                              10) {
                            return "Phone number not valid!";
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    state is! RegisterLoadingState
                        ? defaultButton(
                            child: Text("REGISTER"),
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            })
                        : Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("You Already Have an Account?"),
                        TextButton(
                            onPressed: () =>
                                navigatAndFinish(context, LogInScreen()),
                            child: Text("LOG IN"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
