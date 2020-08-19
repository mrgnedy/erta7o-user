import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/repository/order_repo.dart';
import 'package:erta7o/data/repository/restaurants_repo.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/ui/anim.dart';
import 'package:erta7o/presentation/ui/authPages/authPage.dart';
import 'package:erta7o/presentation/ui/authPages/verifyPage.dart';
import 'package:erta7o/presentation/ui/mainPage/mainPage.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/offers_page.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/orderDetails.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/ordersPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'data/repository/auth_repo.dart';
import 'generated/codegen_loader.g.dart';
import 'presentation/ui/authPages/forget_password.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // EasyLocalization.of(context).locale= Locale('ar', 'EG');
    return EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      path: 'assets/translations',
      assetLoader: CodegenLoader(),
      child: Injector(
          inject: [
            Inject(() => AuthStore(AuthRepo()), isLazy: false),
            Inject(() => RestaurantsStore(RestaurantsRepo()), isLazy: false),
            Inject(() => OrderStore(OrderRepo()), isLazy: false),
          ],
          builder: (context) {
            return MaterialApp(
                supportedLocales: EasyLocalization.of(context).supportedLocales,
                locale: EasyLocalization.of(context).locale,
                localizationsDelegates: [
                  EasyLocalization.of(context).delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                title: 'إرتاحوا',
                theme: ThemeData(
                  textTheme: TextTheme(
                    body1: TextStyle(color: Colors.white, fontFamily: 'bein'),
                    caption: TextStyle(color: Colors.white.withOpacity(0.5)),
                    subhead: TextStyle(color: Colors.white, fontFamily: 'bein'),
                    body2: TextStyle(color: Colors.white, fontFamily: 'bein'),
                    display1:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    display2:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    display3:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    display4:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    title: TextStyle(color: Colors.white, fontFamily: 'bein'),
                    subtitle:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    button: TextStyle(color: Colors.white, fontFamily: 'bein'),
                    headline:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                    overline:
                        TextStyle(color: Colors.white, fontFamily: 'bein'),
                  ),
                  scaffoldBackgroundColor: ColorsD.main,
                  appBarTheme: AppBarTheme(color: ColorsD.main),
                  primarySwatch: Colors.blue,
                ),
                builder: ExtendedNavigator<Router>(router: Router()),
                home: ForgetPassword()
                //RestaurantDetails(restaurantData: RestaurantData(),),
                );
          }),
    );
  }
}
