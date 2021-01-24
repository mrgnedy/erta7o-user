import 'package:auto_route/auto_route.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/state/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../router.gr.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsD.main,
      body: WhenRebuilderOr(
        observeMany: [
          () => RM.get<AuthStore>(),
          () => RM.get<RestaurantsStore>(),
        ],
        initState: (c, rm) => getInitData(),
        builder: (context, model) => Center(
          child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
        ),
      ),
    );
  }

  getInitData() {
    RM.get<AuthStore>().setState(
          (s) async => await s.checkForSavedCredentials(),
          onError: (context, error) => print("Splash ERROR $error"),
          onData: (c, m) {
            return RM.get<RestaurantsStore>().setState(
                  (s) => s.getHome(),
                  onData: (context, model) => ExtendedNavigator.rootNavigator
                      .pushReplacementNamed(Routes.mainUserPage),
                );
          },
        );
  }
}
