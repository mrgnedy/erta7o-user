import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/data/models/order_byid_model.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/productDetails/subWidgets/done_action.dart';
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
        _BuildCustomBtn(
            label: LocaleKeys.addMoreOrders,
            onTap: () {
              IN.get<OrderStore>().currentOrder.data.first.order.restaurantId =
                  IN.get<RestaurantsStore>().currentRestoID;
              IN.get<OrderStore>().currentOrder.data.first.menus.last
                ..menuId = IN.get<RestaurantsStore>().currentProduct.id;
              IN.get<OrderStore>().currentOrder.data.first.menus.last
                ..menuEn = IN.get<RestaurantsStore>().currentProduct.nameEn;
              IN.get<OrderStore>().currentOrder.data.first.menus.last
                ..menuAr = IN.get<RestaurantsStore>().currentProduct.nameAr;

              IN.get<OrderStore>().currentOrder.data.first.menus.last
                ..price =
                    num.parse(IN.get<RestaurantsStore>().currentProduct.price)
                        .toDouble();
              IN.get<OrderStore>().currentOrder.data.first.menus.add(Menus());
              ExtendedNavigator.rootNavigator.pop();
            }),
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
          height: size.height / 2.4,
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
