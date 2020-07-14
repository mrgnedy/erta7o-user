// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:erta7o/presentation/ui/mainPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails.dart';
import 'package:erta7o/presentation/widgets/map.dart';

abstract class Routes {
  static const mainUserPage = '/';
  static const restaurantDetails = '/restaurant-details';
  static const menuPage = '/menu-page';
  static const productDetailsPage = '/product-details-page';
  static const mapScreen = '/map-screen';
  static const all = {
    mainUserPage,
    restaurantDetails,
    menuPage,
    productDetailsPage,
    mapScreen,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainUserPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainUserPage(),
          settings: settings,
        );
      case Routes.restaurantDetails:
        if (hasInvalidArgs<RestaurantDetailsArguments>(args)) {
          return misTypedArgsRoute<RestaurantDetailsArguments>(args);
        }
        final typedArgs =
            args as RestaurantDetailsArguments ?? RestaurantDetailsArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => RestaurantDetails(
              key: typedArgs.key, restaurantData: typedArgs.restaurantData),
          settings: settings,
        );
      case Routes.menuPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MenuPage(),
          settings: settings,
        );
      case Routes.productDetailsPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ProductDetailsPage(),
          settings: settings,
        );
      case Routes.mapScreen:
        if (hasInvalidArgs<MapScreenArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<MapScreenArguments>(args);
        }
        final typedArgs = args as MapScreenArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => MapScreen(typedArgs.setLocation),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//RestaurantDetails arguments holder class
class RestaurantDetailsArguments {
  final Key key;
  final RestaurantData restaurantData;
  RestaurantDetailsArguments({this.key, this.restaurantData});
}

//MapScreen arguments holder class
class MapScreenArguments {
  final Function setLocation;
  MapScreenArguments({@required this.setLocation});
}
