import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/core/api_utils.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/data/models/user_home_model.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const RestaurantAppBar({Key key, this.height}) : super(key: key);
  Restaurants get restaurantData =>
      IN.get<RestaurantsStore>().currentRestaurant.data.restaurant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      title: Txt(isAr(context) ? restaurantData.nameAr : restaurantData.nameEn),
      subtitle: Txt('${restaurantData.desc}'),
      trailing: IconButton(
          icon: Transform.rotate(
            angle: pi,
            child: Icon(Icons.arrow_back)),
          color: Colors.white,
          onPressed: () => ExtendedNavigator.rootNavigator.pop()),
      leading: Container(
        width: size.height / 12,
        height: size.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
          image: DecorationImage(
              image:
                  NetworkImage('${APIs.imageBaseUrl}${restaurantData.image}'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
