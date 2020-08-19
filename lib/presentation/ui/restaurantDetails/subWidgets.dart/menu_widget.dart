import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class BuildMenus extends StatelessWidget {
  List<Products> get products =>
      IN.get<RestaurantsStore>().currentRestaurant.data.products;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () =>
              ExtendedNavigator.rootNavigator.pushNamed(Routes.menuPage),
          child: Row(
            children: <Widget>[
              Txt(LocaleKeys.menu),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.white)
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              products.take(4).length,
              (index) {
                return Container(
                  height: size.height / 12,
                  width: size.height / 12,
                  margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(
                            '${APIs.imageBaseUrl}${products[index].image}'),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
