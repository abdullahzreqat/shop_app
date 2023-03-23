import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/home_cubit/home_cubit.dart';
import 'package:shop_app/Cubit/home_cubit/home_states.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchModel? model = HomeCubit.get(context).searchModel;
          return Scaffold(
            appBar: AppBar(
              title: Text("Search"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      HomeCubit.get(context).getSearch(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchLoadingState)
                    CircularProgressIndicator()
                  else
                    if (model != null && model.data!.product.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: model.data!.product.length,
                          separatorBuilder: (context, index) => Divider(
                                height: 20,
                                color: Colors.grey,
                              ),
                          itemBuilder: (context, index) =>
                              buildResultProduct(model, index, context)),
                    )
                  else if (model != null && model.data!.product.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text("No results found.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.grey,
                                )),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }

  Widget buildResultProduct(SearchModel model, index, context) {
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
                    image: NetworkImage(model.data!.product[index].image!)),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.data!.product[index].name!,
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
                        '${(model.data!.product[index].price / 43.5).toStringAsFixed(2)} JD',
                        style: TextStyle(
                            color: defaultColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Spacer(),
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
