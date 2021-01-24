import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/order_byid_model.dart';
import 'package:erta7o/data/models/order_model.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails/subWidgets/add_actions.dart';
import 'package:erta7o/presentation/widgets/tet_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

// class ProductDetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WhenRebuilder(
//       observe: ()=>RM,
//       onIdle: null,
//       onWaiting: null,
//       onError: null,
//       onData: null,
//     );
//   }
// }

class ProductDetailsPage extends StatelessWidget {
  Products get product => IN.get<RestaurantsStore>().currentProduct;
  Size size;

  @override
  Widget build(BuildContext context) {
    // context.locale = Locale('ar');
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      // height: size.height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildProductImage(),
            _BuildProdctName(),
            buildProductPrice(),
            buildProductConfig(),
            buildAdditions(),
            BuildAction(),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage() {
    return Container(
      height: size.height / 4,
      width: size.width * 0.6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${APIs.imageBaseUrl}${product.image}',
          ),
        ),
      ),
    );
  }

  Widget buildProductPrice() {
    return Txt(
      '${LocaleKeys.price}: ${product.price} ${LocaleKeys.currency}',
      style: TxtStyle()
        ..alignment.center()
        ..alignmentContent.center()
        ..textColor(Colors.white),
    );
  }

  List<Menus> get products =>
      IN.get<OrderStore>().currentOrder.data.first.menus;
  // List<Product> get products => IN.get<RestaurantsStore>().orderProductModel.products;
  set setProduct(Menus p) {
    // IN.get<OrderStore>().currentOrder.data.first.menus.last..menuId = IN.get<RestaurantsStore>().currentProduct.id;
    IN.get<OrderStore>().currentOrder.data.first.menus.last = p;
    print('No. of products: ${products.length}\t${products.last.toJson()}');
  }

  List<String> sandwitchTypes = [
    LocaleKeys.small,
    LocaleKeys.medium,
    LocaleKeys.large,
    LocaleKeys.combo,
  ];

  int selectedType = 0;

  Widget buildProductConfig() {
    return Container(
      width: size.width * 0.81,
      child: StatefulBuilder(builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(LocaleKeys.sandwitchType),
                ...List.generate(sandwitchTypes.length, (index) {
                  return Container(
                    height: size.height / 20,
                    width: size.width * 0.42,
                    child: RadioListTile(
                        value: index,
                        title: Txt(sandwitchTypes[index]),
                        activeColor: Colors.white,
                        groupValue: selectedType,
                        onChanged: (i) {
                          setProduct = products.last..type = i;
                          setState(() => selectedType = i);
                        }),
                  );
                }) //erfa kamon 7elba ganzbel lemon x2
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Txt(LocaleKeys.qty), buildCounter()],
            ),
          ],
        );
      }),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Txt(LocaleKeys.orderDetails),
    );
  }

  int count = 1;
  Widget buildCounter() {
    final style = ParentStyle()
      ..border(all: 1, color: Colors.white)
      ..borderRadius(all: 8)
      ..padding(all: 0)
      ..width(size.width * 0.35)
      ..height(size.height / 16);

    return StatefulBuilder(builder: (context, setState) {
      return Parent(
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                onPressed: count <= 1
                    ? null
                    : () {
                        setState(() => count--);
                        setProduct = products.last..quantity = '$count';
                      },
                icon: Icon(Icons.remove),
                color: Colors.white),
            Txt("$count"),
            IconButton(
              onPressed: () {
                setState(() => count++);
                setProduct = products.last..quantity = '$count';
              },
              alignment: Alignment.center,
              icon: Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
      );
    });
  }

  Widget buildAdditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Txt(
            LocaleKeys.additions,
            style: TxtStyle()
              ..fontSize(18)
              ..textColor(Colors.white),
          ),
          Container(
            height: size.height / 14,
            width: size.width * 0.8,
            child: TextFormField(
              onChanged: (s) {
                setProduct = products.last..addittions = s;
              },
              cursorColor: Colors.white,
              cursorRadius: Radius.circular(10),
              style: TextStyle(height: 1.5),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildProdctName extends StatelessWidget {
  Products get product => IN.get<RestaurantsStore>().currentProduct;
  @override
  Widget build(BuildContext context) {
    return Txt(
      '${isAr(context) ? product.nameAr : product.nameEn}',
      style: TxtStyle()
        ..alignment.center()
        ..alignmentContent.center()
        ..textColor(Colors.white),
    );
  }
}
