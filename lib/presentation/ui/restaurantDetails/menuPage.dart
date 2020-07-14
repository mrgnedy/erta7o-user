import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            30,
            (index) {
              return MenuCard();
            },
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Txt(LocaleKeys.menu),
    );
  }
}

class MenuCard extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      width: size.width / 2.4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              cacheHeight: size.height ~/ 6,
              cacheWidth: size.width ~/ 3,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Txt(
                'برجر فظيع جدا',
                style: TxtStyle(),
              ),
            ),
            buildOrderBtn()
          ],
        ),
      ),
    );
  }

  Widget buildOrderBtn() {
    final gesture = Gestures()
      ..onTap(() =>
          ExtendedNavigator.rootNavigator.pushNamed(Routes.productDetailsPage));
    final style = TxtStyle()
      ..textColor(Colors.white)
      ..background.color(ColorsD.main)
      ..alignment.center()
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..width(size.width / 5.5)
      ..height(size.height / 17);
    return Txt(
      LocaleKeys.order,
      style: style,
      gesture: gesture,
    );
  }
}
