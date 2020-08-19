// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:erta7o/presentation/ui/mainPage/mainPage.dart';
import 'package:erta7o/presentation/ui/authPages/authPage.dart';
import 'package:erta7o/presentation/ui/authPages/verifyPage.dart';
import 'package:erta7o/presentation/ui/authPages/forget_password.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails/productDetails.dart';
import 'package:erta7o/presentation/widgets/map.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/orderDetails.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/offers_page.dart';

abstract class Routes {
  static const mainUserPage = '/main-user-page';
  static const authPage = '/';
  static const verifyPage = '/verify-page';
  static const forgetPassword = '/forget-password';
  static const restaurantDetails = '/restaurant-details';
  static const menuPage = '/menu-page';
  static const productDetailsPage = '/product-details-page';
  static const mapScreen = '/map-screen';
  static const orderDetailsPage = '/order-details-page';
  static const offersPage = '/offers-page';
  static const all = {
    mainUserPage,
    authPage,
    verifyPage,
    forgetPassword,
    restaurantDetails,
    menuPage,
    productDetailsPage,
    mapScreen,
    orderDetailsPage,
    offersPage,
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
      case Routes.authPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AuthPage(),
          settings: settings,
        );
      case Routes.verifyPage:
        if (hasInvalidArgs<VerifyPageArguments>(args)) {
          return misTypedArgsRoute<VerifyPageArguments>(args);
        }
        final typedArgs = args as VerifyPageArguments ?? VerifyPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              VerifyPage(key: typedArgs.key, isForget: typedArgs.isForget),
          settings: settings,
        );
      case Routes.forgetPassword:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ForgetPassword(),
          settings: settings,
        );
      case Routes.restaurantDetails:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RestaurantDetails(),
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
        return MaterialPageRoute<dynamic>(
          builder: (context) => MapScreen(),
          settings: settings,
        );
      case Routes.orderDetailsPage:
        if (hasInvalidArgs<OrderDetailsPageArguments>(args)) {
          return misTypedArgsRoute<OrderDetailsPageArguments>(args);
        }
        final typedArgs =
            args as OrderDetailsPageArguments ?? OrderDetailsPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => OrderDetailsPage(
              key: typedArgs.key, unConfirmed: typedArgs.unConfirmed),
          settings: settings,
        );
      case Routes.offersPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => OffersPage(),
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

//VerifyPage arguments holder class
class VerifyPageArguments {
  final Key key;
  final bool isForget;
  VerifyPageArguments({this.key, this.isForget = false});
}

//OrderDetailsPage arguments holder class
class OrderDetailsPageArguments {
  final Key key;
  final bool unConfirmed;
  OrderDetailsPageArguments({this.key, this.unConfirmed});
}
