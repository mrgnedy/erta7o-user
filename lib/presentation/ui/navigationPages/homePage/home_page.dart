import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/filters.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/restaurants.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BuildSlider(),
          IN.get<AuthStore>().isAuth ? BuildFilters() : Container(height: 45),
          BuildRestaurantsCards()
        ],
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BuildSlider(),
          BuildFilters(),
          BuildRestaurantsCards()
        ],
      ),
    );
  }
}
