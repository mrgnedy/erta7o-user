import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:erta7o/presentation/widgets/waiting_widget.dart';

import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/build_progress.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/order_actions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:steps_indicator/steps_indicator.dart';

class OrderDetailsPage extends StatelessWidget {
  bool unConfirmed;
  // GlobalKey progressKey = GlobalKey();

  OrderDetailsPage({Key key, this.unConfirmed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                IN.get<OrderStore>().isConfirmed = true;
                ExtendedNavigator.rootNavigator.pop();
              },
              child: Icon(Icons.arrow_back)),
          title: Txt(LocaleKeys.orderDetails),
          elevation: 0,
        ),
        body: WhenRebuilderOr<OrderStore>(
          initState: (c, rm) => rm.setState((s) => s.showOrderByid()),
          observe: () => RM.get<OrderStore>(),
          builder: (context, model) => _OnData(),
          onWaiting: () => WaitingWidget(),
        ),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
  
    size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        heightFactor: 1.2,
        child: Column(
          children: <Widget>[
            BuildProgress(),
            buildOrderDetails(context),
            buildAddressDetails(context),
            BuildOrderActions()
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StylesD.richText(
                mainText: LocaleKeys.qty,
                locale: context.locale,
                subText: 'LocaleKeys',
                width: size.width),
            StylesD.richText(
                mainText: LocaleKeys.sandwitchType,
                locale: context.locale,
                subText: 'LocaleKeys',
                width: size.width),
            StylesD.richText(
                mainText: LocaleKeys.additions,
                locale: context.locale,
                subText: 'LocaleKeys',
                width: size.width),
            StylesD.richText(
                mainText: LocaleKeys.qty,
                locale: context.locale,
                subText: 'LocaleKeys',
                width: size.width),
          ],
        ),
      ),
    );
  }

  Widget buildAddressDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StylesD.richText(
                width: size.width,
                locale: context.locale,
                mainText: LocaleKeys.qty,
                subText: 'LocaleKeys'),
            StylesD.richText(
                width: size.width,
                locale: context.locale,
                mainText: LocaleKeys.qty,
                subText: 'LocaleKeys'),
            StylesD.richText(
                width: size.width,
                mainText: LocaleKeys.qty,
                locale: context.locale,
                subText: 'LocaleKeys'),
            StylesD.richText(
                width: size.width,
                locale: context.locale,
                mainText: LocaleKeys.qty,
                subText: 'LocaleKeys'),
            StylesD.richText(
                width: size.width,
                locale: context.locale,
                mainText: LocaleKeys.qty,
                subText: 'LocaleKeys'),
          ],
        ),
      ),
    );
  }

  Widget buildRate(context) {
    final style = TxtStyle()
      ..alignmentContent.center()
      ..borderRadius(all: 12)
      ..textColor(ColorsD.main)
      ..background.color(Colors.white)
      ..height(isPortrait(context) ? size.height / 16 : size.height / 8)
      ..width(isPortrait(context) ? size.width * 0.4 : size.width * 0.2);
    final gesure = Gestures()..onTap(() => showRateDialoge(context));
    return Txt('تقييم المندوب', style: style, gesture: gesure);
  }

  double rate = 0;
  getRate(r) => rate = r;
  showRateDialoge(context) async {
    final style = TxtStyle()..textColor(ColorsD.main);
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: size.height / 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Txt('قيم المندوب', style: style),
              Divider(color: ColorsD.main, endIndent: 10, indent: 10),
              Directionality(
                textDirection: TextDirection.ltr,
                child: SmoothStarRating(
                    onRated: getRate,
                    rating: rate,
                    starCount: 5,
                    color: Colors.amber,
                    borderColor: Colors.amber),
              ),
              Txt('ارساال', style: style)
            ],
          ),
        ),
      ),
    );
  }
}
