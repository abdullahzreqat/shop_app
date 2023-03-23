import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Shared/components/components.dart';

class SettingsScreen extends StatelessWidget {

  String? nameUser;
  String? emailUser;
  String ?phoneUser;
  String ?imageUser;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is LogOutSuccessState) {
          if (state.status) {
            showToast(state: ToastState.success, message: state.message);
            signOut(context);
          } else {
            showToast(state: ToastState.error, message: state.message);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(condition: HomeCubit
            .get(context)
            .userModel != null,
            builder: (context) =>
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: 85,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors
                                  .grey[350]),
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(HomeCubit
                                    .get(context)
                                    .userModel!
                                    .data!
                                    .image!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: 10.0,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white60,
                                radius: 12,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),

                      infoContainer(
                          icon: Icon(Icons.person),
                          text: HomeCubit
                              .get(context)
                              .userModel!
                              .data!
                              .name,
                          context: context),
                      Spacer(),
                      infoContainer(
                          icon: Icon(Icons.email_outlined),
                          text: HomeCubit
                              .get(context)
                              .userModel!
                              .data!
                              .email
                          ,
                          context: context),
                      Spacer(),
                      infoContainer(
                          icon: Icon(Icons.phone),
                          text: HomeCubit
                              .get(context)
                              .userModel!
                              .data!
                              .phone,
                          context: context),
                      Spacer(
                        flex: 2,
                      ),
                      state is! LogOutLoadingState
                          ? defaultButton(
                          child: Text("LOG OUT"),
                          onClick: () {
                            HomeCubit.get(context).logOutState(context);
                          },
                          height: 50)
                          : CircularProgressIndicator(),
                      Spacer(
                        flex: 5,
                      ),
                    ],
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator(),));
      },
    );
  }

  Widget infoContainer({
    required context,
    icon,
    text,
  }) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
