import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'core/utils.dart';
import 'data/repository/account_repo.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/order_repo.dart';
import 'data/repository/restaurants_repo.dart';
import 'data/repository/setting_repo.dart';
import 'generated/codegen_loader.g.dart';
import 'presentation/router.gr.dart';
import 'presentation/state/account_store.dart';
import 'presentation/state/auth_store.dart';
import 'presentation/state/order_store.dart';
import 'presentation/state/restaurants_store.dart';
import 'presentation/state/setting_store.dart';
import 'presentation/ui/authPages/forget_password.dart';
import 'presentation/ui/navigationPages/homePage/subWidgets/app_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // WidgetsBinding.;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // EasyLocalization.of(context).locale= Locale('ar', 'EG');
    return EasyLocalization(
      startLocale: Locale('ar'),
      supportedLocales: [Locale('ar'), Locale('en')],
      fallbackLocale: Locale('ar'),
      useOnlyLangCode: true,
      path: 'assets/translations',
      assetLoader: CodegenLoader(),
      child: Injector(
          inject: [
            Inject(() => AuthStore(AuthRepo()), isLazy: false),
            Inject(() => SettingStore(SettingRepo()), isLazy: false),
            Inject(() => RestaurantsStore(RestaurantsRepo()), isLazy: false),
            Inject(() => OrderStore(OrderRepo()), isLazy: false),
            Inject(() => HomeAppBarStore()),
            Inject(() => AccountStore(AccountRepo())),
          ],
          builder: (context) {
            return  MaterialApp(
                debugShowCheckedModeBanner: false,
                  supportedLocales:
                      EasyLocalization.of(context).supportedLocales,
                  locale: EasyLocalization.of(context).locale,
                  localizationsDelegates: [
                    EasyLocalization.of(context).delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  title: 'إرتاحوا',
                  theme: ThemeData(
                    fontFamily: 'bein',
                    textTheme: TextTheme(
                      body1: TextStyle(color: Colors.white, fontFamily: 'bein'),
                      caption: TextStyle(color: Colors.white.withOpacity(0.5)),
                      subhead:
                          TextStyle(color: Colors.white, fontFamily: 'bein'),
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
                      button:
                          TextStyle(color: Colors.white, fontFamily: 'bein'),
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
