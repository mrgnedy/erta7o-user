import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HomeAppBarStore {
  int index = 0;
}

class HomeAppBar extends PreferredSize {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double height;

  HomeAppBar({this.scaffoldKey, this.height});

  final List titles = [
    LocaleKeys.mainNav,
    LocaleKeys.ordersNav,
    LocaleKeys.notificationNav,
    LocaleKeys.accountNav
  ];
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      observe: () => RM.get<HomeAppBarStore>(),
      builder: (context, model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                child: Image.asset(R.ASSETS_IMAGES_MENU_PNG),
                onTap: () => scaffoldKey.currentState.openDrawer()),
            Txt(titles[IN.get<HomeAppBarStore>().index],
                style: TxtStyle()
                  ..fontSize(26)
                  ..textColor(Colors.white)),
            // animatedSearchWidget(),
            Container(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
