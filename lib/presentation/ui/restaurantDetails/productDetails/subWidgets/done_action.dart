import 'package:request_mandoub/data/models/orders_model.dart';
import 'package:request_mandoub/data/models/order_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/ui/mainPage/mainPage.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

// OrderModel get orderModel => IN.get<OrderStore>().orderModel;
class BuildDoneAction extends StatelessWidget {
  final doneGesture = Gestures()
    ..onTap(() async {
      IN.get<OrderStore>().currentOrder.data.first.order.copon =
          IN.get<OrderStore>().copoun;
      // ExtendedNavigator.rootNavigator.pop();
      IN.get<OrderStore>().currentOrder.data.first.order.restaurantId =
          IN.get<RestaurantsStore>().currentRestoID;
    IN.get<OrderStore>().currentOrder.data.first.menus.last
      ..menuId = IN.get<RestaurantsStore>().currentProduct.id;
    IN.get<OrderStore>().currentOrder.data.first.menus.last
      ..menuEn = IN.get<RestaurantsStore>().currentProduct.nameEn;
    IN.get<OrderStore>().currentOrder.data.first.menus.last
      ..menuAr = IN.get<RestaurantsStore>().currentProduct.nameAr;
    IN.get<OrderStore>().currentOrder.data.first.menus.last
      ..price = num.parse(IN.get<RestaurantsStore>().currentProduct.price).toDouble();
      IN.get<OrderStore>().isConfirmed = false;
      final x = (await ExtendedNavigator.rootNavigator
          .pushNamed(Routes.mapScreen)) as Position;

      if (x != null) {
        final address = (await Geocoder.local.findAddressesFromCoordinates(
                Coordinates(x.latitude, x.longitude)))
            .first;
        print('Address Summary\n: ${address.toMap()}');
        IN.get<OrderStore>().currentOrder.data.first.order.address =
            address.addressLine;
        IN.get<OrderStore>().currentOrder.data.first.order.lat =
            x.latitude.toString();
        IN.get<OrderStore>().currentOrder.data.first.order.lng =
            x.longitude.toString();
      }
      ExtendedNavigator.rootNavigator.pushNamedAndRemoveUntil(
          Routes.orderDetailsPage, ModalRoute.withName(Routes.mainUserPage),
          arguments: OrderDetailsPageArguments(unConfirmed: false));
    });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final doneStyle = TxtStyle()
      ..width(size.width * 0.2)
      ..height(size.height / 18)
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..background.color(ColorsD.main)
      ..textColor(Colors.white);
    return Txt(LocaleKeys.done, style: doneStyle, gesture: doneGesture);
  }
}
