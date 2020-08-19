import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context).copyWith(
          textTheme:
              TextTheme(body1: TextStyle(color: Colors.black, fontSize: 18))),
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
                  Image.asset(R.ASSETS_IMAGES_CHECK_PNG),
                  SizedBox(height: size.height * 0.08),
                  Container(
                    height: size.width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Txt(LocaleKeys.main),
                        Txt(LocaleKeys.whoWeAre),
                        Txt(LocaleKeys.rateApp),
                        Txt(LocaleKeys.contactUs),
                        Txt(LocaleKeys.howToOrder),
                        Divider(),
                        Txt(
                          LocaleKeys.logOut,
                          style: TxtStyle()..textColor(Colors.red),
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
}
