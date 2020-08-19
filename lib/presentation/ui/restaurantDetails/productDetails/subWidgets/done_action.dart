import 'package:erta7o/data/models/orders_model.dart';
import 'package:erta7o/data/models/order_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';


OrderModel get orderModel => IN.get<OrderStore>().orderModel;
class BuildDoneAction extends StatelessWidget {
  final doneGesture = Gestures()
    ..onTap(() async {
      IN.get<OrderStore>().orderModel.copoun =
          IN.get<OrderStore>().copoun;
          ExtendedNavigator.rootNavigator.pop();
          final x = (await ExtendedNavigator.rootNavigator
              .pushNamed(Routes.mapScreen)) as Position;

          if (x != null) {
            final address = (await Geocoder.local.findAddressesFromCoordinates(
                    Coordinates(x.latitude, x.longitude)))
                .first;
            print('Address Summary\n: ${address.toMap()}');
            IN.get<OrderStore>().orderModel.address = address.addressLine;
            IN.get<OrderStore>().orderModel.lat = x.latitude.toString();
            IN.get<OrderStore>().orderModel.lng= x.longitude.toString();
            IN.get<OrderStore>().orderModel.restaurantID= IN.get<RestaurantsStore>().currentRestoID.toString();
            IN.get<OrderStore>().isConfirmed= false;
            // IN.get<OrderStore>().currentOrder = OrderDetail(
                
            // );
            ExtendedNavigator.rootNavigator.pushNamed(Routes.orderDetailsPage, arguments: OrderDetailsPageArguments(unConfirmed: false));
          }
      
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
