import 'package:division/division.dart';
import 'package:erta7o/data/models/restaurants_model.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/widgets/auction_card.dart';
import 'package:erta7o/presentation/widgets/error_widget.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildRestaurantsCards extends StatelessWidget {
  RMKey<RestaurantsStore> restoKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
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
    return restaurants.isEmpty? Center(child: Txt('لا توجد'),): Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        restaurants.length,
        (index) => RestaurantCard(restaurant: restaurants[index]),
      ),
    );
  } 
}
