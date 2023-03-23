import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is FavoriteSuccessPostState) {
        if (state.status) {
          showToast(state: ToastState.success, message: state.message);
        } else {
          showToast(state: ToastState.error, message: state.message);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: HomeCubit.get(context).favoriteModel != null && HomeCubit.get(context).favoriteModel!.data!.data!.isNotEmpty,
        builder: (context) =>  Padding(
                padding: EdgeInsets.all(14),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildFavProduct(
                        context: context,
                        model: HomeCubit.get(context)
                            .favoriteModel!
                            .data!
                            .data![index]),
                    separatorBuilder: (context, index) => Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                    itemCount: HomeCubit.get(context)
                        .favoriteModel!
                        .data!
                        .data!
                        .length),
              )
           ,
        fallback: (context) => state is !FavoriteLoadingGetState ? Center(
          child: Text("There's no favorite products.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey,
                  ))
        ): Center(child: CircularProgressIndicator()),
      );
    });
  }

  Widget buildFavProduct({required context, required FavoriteData? model}) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[350]!)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                    fit: BoxFit.fill,
                    width: 100,
                    image: NetworkImage(model!.product!.image!)),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black, height: 1.2),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '${(model.product!.price / 43.5).toStringAsFixed(2)} JD',
                        style: TextStyle(
                            color: defaultColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${(model.product!.oldPrice / 43.5).round()} JD',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12),
                        ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 20.0),
                        child: InkWell(
                          onTap: () {
                            HomeCubit.get(context)
                                .changeFavState(model.product!.id!);
                          },
                          child: Icon(
                            !HomeCubit.get(context)
                                    .favProducts[model.product!.id]!
                                ? Icons.favorite_border
                                : Icons.favorite,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
