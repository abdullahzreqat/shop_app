// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/Modules/login_screen/login_screen.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/network/local/cached_data.dart';
import 'package:shop_app/Shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boarding {
  final String image;
  final String title;
  final String body;

  Boarding({required this.image, required this.title, required this.body});
}

class OnBoardScreen extends StatefulWidget {
  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var pageController = PageController();
  List<Boarding> boardingItems = [
    Boarding(
        image: 'assets/images/shopping-fun.jpeg',
        title: "Discover",
        body: "Explore world's top brands and boutiques."),
    Boarding(
        image: 'assets/images/payment.jpg',
        title: "Make the payment",
        body: "Choose the preferable option of payment."),
    Boarding(
        image: 'assets/images/enjoy.jpg',
        title: "Enjoy your shopping",
        body: "Get high quality products for the best prices."),
  ];

  bool isLast = false;

  void submit() {
    UserCached.setData(key: "onBoarding", value: false)
        .then((value) => navigatAndFinish(context, LogInScreen()))
        .catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                        fontSize: 16,
                        color: defaultColor.withOpacity(.6),
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (i) {
                    if (i == boardingItems.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      isLast = false;
                    }
                  },
                  itemBuilder: (context, i) {
                    return pageItemBuilder(context, boardingItems[i]);
                  },
                  itemCount: boardingItems.length,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                   showIndicator(controller: pageController,length: boardingItems.length),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        }
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget pageItemBuilder(context, item) => Column(
      children: [
        Expanded(
          child: Image.asset(
            item.image,
            height: MediaQuery.of(context).size.height / 3,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
        ),
        Text(item.title, style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(
          height: 20,
        ),
        Text(item.body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge),
      ],
    );
