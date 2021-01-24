import 'package:erta7o/core/utils.dart';
import 'package:app_review/app_review.dart';
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/state/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../router.gr.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(
          body1: TextStyle( color: Colors.black, fontSize: 18, fontFamily: 'bein'),
        ),
      ),
      child: Container(
        width: size.width * 0.5,
        child: Drawer(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Image.asset(R.ASSETS_IMAGES_LOGO_PNG, color: ColorsD.main,),
                  SizedBox(height: size.height * 0.08),
                  Container(
                    // height: size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                            visible: !IN.get<AuthStore>().isAuth,
                            child: Txt(
                              LocaleKeys.signin,
                              gesture: Gestures()..onTap(goToAtuh),
                            )),
                        Txt(LocaleKeys.whoWeAre,
                            gesture: Gestures()
                              ..onTap(() =>
                                  navigateTo(LocaleKeys.whoWeAre, 'about'))),
                        Txt(LocaleKeys.termsOfUse,
                            gesture: Gestures()
                              ..onTap(() =>
                                  navigateTo(LocaleKeys.termsOfUse, 'usage'))),
                        Txt(LocaleKeys.policy,
                            gesture: Gestures()
                              ..onTap(() =>
                                  navigateTo(LocaleKeys.policy, 'policy'))),
                        Txt(LocaleKeys.rateApp, gesture: Gestures()..onTap(() {
                          AppReview. requestReview;
                        }),),
                        Txt(
                          LocaleKeys.contactUs,
                          gesture: Gestures()
                            ..onTap(
                              () {
                                ExtendedNavigator.rootNavigator
                                    .pushNamed(Routes.contactUs);
                              },
                            ),
                        ),
                        Txt(LocaleKeys.HowToOrder,
                            gesture: Gestures()
                              ..onTap(() =>
                                  navigateTo(LocaleKeys.HowToOrder, 'how'))),
                        Divider(),
                        Visibility(
                          visible: IN.get<AuthStore>().isAuth,
                          child: Txt(
                            LocaleKeys.LogOut,
                            style: TxtStyle()..textColor(Colors.red),
                            gesture: Gestures()
                              ..onTap(
                                () {
                                  IN.get<AuthStore>().pref.clear();
                                  ExtendedNavigator.rootNavigator
                                      .pushNamedAndRemoveUntil(
                                          Routes.authPage, (route) => false);
                                },
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  goToAtuh() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    ExtendedNavigator.rootNavigator.pushNamed(Routes.authPage);
  }

  navigateTo(String title, String label) {
    print('This is Settings ${IN.get<SettingStore>().settingsModel?.toJson()}');

    ExtendedNavigator.rootNavigator.pushNamed(Routes.aboutPage,
        arguments: AboutPageArguments(title: title, label: label));
  }
}
