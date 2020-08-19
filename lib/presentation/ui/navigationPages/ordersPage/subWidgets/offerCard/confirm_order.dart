import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ConfirmOfferBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      observe: () => RM.get<OrderStore>(),
      tag: 'confirmDelivery',
      builder: (context, model) => _OnData(),
      onWaiting: () => WaitingWidget(
        color: ColorsD.main,
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  bool isLoading = false;
  static Size size = RM.mediaQuery.size;
  final yesStyle = TxtStyle()
    ..textColor(Colors.white)
    ..alignmentContent.center()
    ..background.color(ColorsD.main)
    ..borderRadius(all: 5)
    ..width(isPortrait(RM.context) ? size.width * 0.15 : size.width * 0.15)
    ..height(isPortrait(RM.context) ? size.height * 0.051 : size.height * 0.1);
  final noStyle = TxtStyle()
    ..textColor(ColorsD.main)
    ..alignmentContent.center()
    ..background.color(Colors.white)
    ..border(color: ColorsD.main, all: 1)
    ..borderRadius(all: 5)
    ..width(isPortrait(RM.context) ? size.width * 0.15 : size.width * 0.15)
    ..height(isPortrait(RM.context) ? size.height * 0.051 : size.height * 0.1);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()
      ..onTap(() {
        RM.get<OrderStore>().setState(
              (s) => s.confirmDeliveryOffer(),
              onData: (context, model) => model.getInitOrders(),
            );
      });
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Txt(LocaleKeys.no, style: yesStyle),
        SizedBox(width: size.width * 0.051),
        Txt(LocaleKeys.yes, style: noStyle, gesture: gesture),
      ],
    );
  }
}
