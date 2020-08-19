import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const RestaurantAppBar({Key key, this.height}) : super(key: key);
  Restaurants get restaurantData =>
      IN.get<RestaurantsStore>().currentRestaurant.data. restaurant;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      title: Txt(isAr(context) ? restaurantData.nameAr : restaurantData.nameEn),
      subtitle: Txt('${restaurantData.desc}'),
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
