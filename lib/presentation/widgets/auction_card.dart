import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:division/division.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurants restaurant;

  RestaurantCard({Key key, this.restaurant}) : super(key: key);

  getAddress() async {
    return (await Geocoder.local.findAddressesFromCoordinates(Coordinates(
            double.parse(restaurant.lat), double.parse(restaurant.lng))))
        .first
        .addressLine;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        IN.get<RestaurantsStore>().currentRestoID = restaurant.id;
        ExtendedNavigator.rootNavigator.pushNamed(Routes.restaurantDetails);
      },
      child: Container(
        width: size.width * 0.8,
        child: Card(
          child: ListTile(
            title: Text(
              '${isAr(context) ? restaurant.nameAr : restaurant.nameEn}',
              softWrap: true,
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.8),
            ),
            isThreeLine: false,
            subtitle: Text('${restaurant.address}',
                style: TextStyle(color: Colors.grey, height: 1.2)),
            trailing: Txt('${restaurant.distance} ${LocaleKeys.kg}', style: TxtStyle()),
            leading: Container(
              height: size.height / 9,
              width: size.height / 9,
              child: CachedNetworkImage(
                imageUrl: '${APIs.imageBaseUrl}${restaurant.image}',
                imageBuilder: (context, imageB) => Container(
                  height: size.height / 9,
                  width: size.height / 9,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageB, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                placeholder: (context, imageStr) => imageStr.contains('null')
                    ? StylesD.noImageWidget()
                    : WaitingWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
