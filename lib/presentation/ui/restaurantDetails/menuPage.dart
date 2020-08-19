import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MenuPage extends StatelessWidget {
  List<Products> get products =>
      IN.get<RestaurantsStore>().currentRestaurant.data.products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            products.length,
            (index) {
              IN.get<RestaurantsStore>().currentProduct = products[index];
              return MenuCard(product: products[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Txt(LocaleKeys.menu),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Products product;
  Size size;

  MenuCard({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      width: size.width / 2.4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              '${APIs.imageBaseUrl}${product.image}',
              cacheHeight: size.height ~/ 6,
              cacheWidth: size.width ~/ 3,
              height: size.height / 6,
              width: size.width / 3,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.05,
                child: Text(
                  '${isAr(context) ? product.nameAr : product.nameEn}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            buildOrderBtn()
          ],
        ),
      ),
    );
  }

  Widget buildOrderBtn() {
    final gesture = Gestures()
      ..onTap(() =>
          ExtendedNavigator.rootNavigator.pushNamed(Routes.productDetailsPage));
    final style = TxtStyle()
      ..textColor(Colors.white)
      ..background.color(ColorsD.main)
      ..alignment.center()
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..width(size.width / 5.5)
      ..height(size.height / 17);
    return Txt(
      LocaleKeys.order,
      style: style,
      gesture: gesture,
    );
  }
}
