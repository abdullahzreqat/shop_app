import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Models/home_model.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/components/constants.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is FavoriteSuccessPostState) {
          if (state.status) {
            showToast(state: ToastState.success, message: state.message);
          } else {
            showToast(state: ToastState.error, message: state.message);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeData != null,
          builder: (context) => productBuild(HomeCubit.get(context).homeData,
              HomeCubit.get(context).categoriesModel, size, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuild(
          HomeModel? model, CategoriesModel? catModel, Size size, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model!.data!.banners.map((e) {
                  return Container(
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(e.image ?? ""),
                        fit: BoxFit.cover,
                      ));
                }).toList(),
                options: CarouselOptions(
                  height: size.height / 4.5,
                  viewportFraction: 1,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Categories",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ConditionalBuilder(
                      condition: HomeCubit.get(context).categoriesModel != null,
                      builder: (context) => buildCategories(catModel),
                      fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          )),
                  Text(
                    "New Products",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                color: Colors.white,
                child: GridView.count(
                  childAspectRatio: 1 / 1.3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                      model.data!.products.length,
                      (index) => buildGridProduct(
                          model.data!.products[index], size, context)),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildCategories(CategoriesModel? catModel) {
    return Container(
      height: 100,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: catModel!.data!.data.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: NetworkImage(catModel.data!.data[index].image!),
                width: 100,
                fit: BoxFit.fill,
              ),
              Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      catModel.data!.data[index].name!.capitalize(),
                      style: TextStyle(color: defaultColor),
                    ),
                  ))
            ],
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 5,
        ),
      ),
    );
  }

  Widget buildGridProduct(ProductModel product, Size size, context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: defaultColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(product.image!),
                  fit: BoxFit.fill,
                  height: size.height / 5,
                  width: double.infinity,
                ),
                if (product.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Discount",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ))
              ],
            ),
            Padding(
                padding: const EdgeInsetsDirectional.only(top: 5.0, start: 5),
                child: Text(
                  product.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.09, fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 5.0, end: 7, bottom: 5),
              child: Row(
                children: [
                  Text(
                    '${(product.price / 43.5).toStringAsFixed(2)} JD',
                    style: TextStyle(
                        color: defaultColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (product.discount != 0)
                    Text(
                      '${(product.oldPrice / 43.5).round()} JD',
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12),
                    ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context).changeFavState(product.id!);
                    },
                    child: Icon(
                      !HomeCubit.get(context).favProducts[product.id]!
                          ? Icons.favorite_border
                          : Icons.favorite,

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
