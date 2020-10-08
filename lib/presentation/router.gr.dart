// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:request_mandoub/presentation/ui/mainPage/mainPage.dart';
import 'package:request_mandoub/presentation/ui/splash_screen.dart';
import 'package:request_mandoub/presentation/ui/authPages/authPage.dart';
import 'package:request_mandoub/presentation/ui/authPages/verifyPage.dart';
import 'package:request_mandoub/presentation/ui/authPages/forget_password.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/productDetails/productDetails.dart';
import 'package:request_mandoub/presentation/widgets/map.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/ordersPage/orderDetails.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/ordersPage/offers_page.dart';
import 'package:request_mandoub/presentation/ui/drawerPages/about_page.dart';
import 'package:request_mandoub/presentation/ui/drawerPages/contact_us.dart';
import 'package:request_mandoub/presentation/ui/authPages/rechange_pw.dart';

abstract class Routes {
  static const mainUserPage = '/main-user-page';
  static const splashScreen = '/';
  static const authPage = '/auth-page';
  static const verifyPage = '/verify-page';
  static const forgetPassword = '/forget-password';
  static const restaurantDetails = '/restaurant-details';
  static const menuPage = '/menu-page';
  static const productDetailsPage = '/product-details-page';
  static const mapScreen = '/map-screen';
  static const orderDetailsPage = '/order-details-page';
  static const offersPage = '/offers-page';
  static const aboutPage = '/about-page';
  static const contactUs = '/contact-us';
  static const rechangePWPage = '/rechange-pw-page';
  static const all = {
    mainUserPage,
    splashScreen,
    authPage,
    verifyPage,
    forgetPassword,
    restaurantDetails,
    menuPage,
    productDetailsPage,
    mapScreen,
    orderDetailsPage,
    offersPage,
    aboutPage,
    contactUs,
    rechangePWPage,
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
        if (hasInvalidArgs<MainUserPageArguments>(args)) {
          return misTypedArgsRoute<MainUserPageArguments>(args);
        }
        final typedArgs =
            args as MainUserPageArguments ?? MainUserPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              MainUserPage(key: typedArgs.key, page: typedArgs.page),
          settings: settings,
        );
      case Routes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashScreen(),
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
      case Routes.aboutPage:
        if (hasInvalidArgs<AboutPageArguments>(args)) {
          return misTypedArgsRoute<AboutPageArguments>(args);
        }
        final typedArgs = args as AboutPageArguments ?? AboutPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AboutPage(
              key: typedArgs.key,
              title: typedArgs.title,
              label: typedArgs.label),
          settings: settings,
        );
      case Routes.contactUs:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ContactUs(),
          settings: settings,
        );
      case Routes.rechangePWPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RechangePWPage(),
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

//MainUserPage arguments holder class
class MainUserPageArguments {
  final Key key;
  final int page;
  MainUserPageArguments({this.key, this.page});
}

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

//AboutPage arguments holder class
class AboutPageArguments {
  final Key key;
  final String title;
  final String label;
  AboutPageArguments({this.key, this.title, this.label});
}
