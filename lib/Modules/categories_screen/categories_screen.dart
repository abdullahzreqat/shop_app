import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.categoriesModel != null,
              builder: (context) =>
                  buildCategories(cubit.categoriesModel, size),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget buildCategories(CategoriesModel? model, Size size) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.count(
          crossAxisSpacing: 5,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 5,
          childAspectRatio: 1 / 1.25,
          crossAxisCount: 2,
          children: List.generate(model!.data!.data.length,
              (index) => buildGridCategories(model.data!.data[index]))),
    );
  }
}

Widget buildGridCategories(CategoriesData model) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[350]!),
        borderRadius: BorderRadius.circular(25)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            image: NetworkImage(model.image!),
            height: 110,
            width: double.infinity,
            fit: BoxFit.fill),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(25)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.name!.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: defaultColor, fontSize: 20, height: 1),
            ),
          ),
        )
      ],
    ),
  );
}
