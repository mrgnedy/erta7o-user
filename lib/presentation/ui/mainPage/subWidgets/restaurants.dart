import 'package:division/division.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:request_mandoub/data/models/restaurants_model.dart';
import 'package:request_mandoub/data/models/user_home_model.dart';
import 'package:request_mandoub/presentation/state/auth_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/widgets/auction_card.dart';
import 'package:request_mandoub/presentation/widgets/error_widget.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildRestaurantsCards extends StatelessWidget {
  RMKey<RestaurantsStore> restoKey = RMKey();
  Position position;
  String address;
  Future getUserLocation() async {
    final permStatus = await Permission.location.request();

    if (permStatus == PermissionStatus.granted) {
      position = await Geolocator().getCurrentPosition();

      final fullAddress = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(position.latitude, position.longitude));
     return address = fullAddress.first.addressLine;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      initState: (context, model)async{
        if(await getUserLocation() != null)
        RM.get<AuthStore>().setState((s) => s.updateLocation(position.latitude, position.longitude, address), onData: (c,m){
           RM.get<RestaurantsStore>().setState((s) => s.getHome());
        });
      },
      observe: () => RM.get<RestaurantsStore>(),
      rmKey: restoKey,
      onData: (data) => _OnData(),
      onError: (error) =>
          restoKey.state.currentFilter == null ? OnErrorWidget() : _OnData(),
      onIdle: () => Container(),
      onWaiting: () =>
          restoKey.state.currentFilter == null ? WaitingWidget() : _OnData(),
    );
  }
}

class _OnData extends StatelessWidget {
  List<Restaurants> get restaurants =>
      IN.get<RestaurantsStore>().currentFilter.data;

  @override
  Widget build(BuildContext context) {
    return restaurants.isEmpty
        ? Center(
            child: Txt('لا توجد'),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              restaurants.length,
              (index) => RestaurantCard(restaurant: restaurants[index]),
            ),
          );
  }
}
