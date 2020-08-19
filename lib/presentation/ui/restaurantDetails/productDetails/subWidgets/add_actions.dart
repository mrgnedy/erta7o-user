import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails/subWidgets/done_action.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';
import 'copoun_widget.dart';
import 'time_widget.dart';

class BuildAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _BuildCustomBtn(label: LocaleKeys.addMoreOrders, onTap: () {}),
        _BuildCustomBtn(
            label: LocaleKeys.completeOrder,
            onTap: () => showTimeDialog(context)),
      ],
    );
  }

  showTimeDialog(context) async {
    final size = MediaQuery.of(context).size;
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: size.height / 2.6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BuildCoupon(),
                  BuildTime(),
                  _BuildDialogActions()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // int hrsCount = 1;

}

class _BuildDialogActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backStyle = TxtStyle()
      ..width(size.width * 0.2)
      ..height(size.height / 18)
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..background.color(Colors.white)
      ..textColor(ColorsD.main)
      ..border(all: 1, color: ColorsD.main);

    final backGesture = Gestures()
      ..onTap(() => ExtendedNavigator.rootNavigator.pop());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Txt(
            LocaleKeys.back,
            style: backStyle,
            gesture: backGesture,
          ),
          SizedBox(width: 10),
          BuildDoneAction()
        ],
      ),
    );
  }
}

class _BuildCustomBtn extends StatelessWidget {
  final String label;
  final Function onTap;

  const _BuildCustomBtn({Key key, this.label, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = TxtStyle()
      ..textColor(ColorsD.main)
      ..fontSize(18)
      ..fontFamily('bein')
      ..borderRadius(all: 5)
      ..width(size.width * 0.38)
      ..height(size.height / 16)
      ..alignmentContent.center()
      ..alignment.center()
      ..margin(horizontal: 5)
      ..background.color(Colors.white);
    final gesture = Gestures()..onTap(onTap);
    return Txt(
      label,
      style: style,
      gesture: gesture,
    );
  }
}
