import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../router.gr.dart';

class BuildOrderActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr<OrderStore>(
      observe: () => RM.get<OrderStore>(),
      builder: (context, model) => BuildOrderAction(),
      onWaiting: () => WaitingWidget(),
    );
  }
}

class BuildOrderAction extends StatelessWidget {
  String label = '';
  Size size;
  Function callback = () {};
  String get status =>
      IN.get<OrderStore>().currentOrder?.data?.first?.order?.status;
  selectAction() {
    if (!IN.get<OrderStore>().isConfirmed) {
      label = LocaleKeys.confrimOrder;
      callback = confirmOrder;
    } else
      switch (status) {
        case '':
        case '0':
          {
            label = LocaleKeys.deliveryOffers;
            callback = showOffers;
          }
          break;
        case '1':
        case '2':
          label = callback = null;
          break;
        case '3':
          {
            label = LocaleKeys.makeDelivered;
            callback = makeDelivered;
          }
          break;
        default:
          {
            label = LocaleKeys.rateDelivery;
            callback = rateDelivery;
          }
      }
  }

  confirmOrder() {
    RM.get<OrderStore>().setState(
      (s) => s.makeOrder().then((value) => s.showOrderByid()),
      onError: (c, e) {
        print(e);
      },
      // onData: (context, model) => model.,
    );
  }

  showOffers() {
    ExtendedNavigator.rootNavigator.pushNamed(Routes.offersPage);
  }

  makeDelivered() {
    RM.get<OrderStore>().setState((s) => s.finishOrder());
  }

  getRate(s) {
    IN.get<OrderStore>().rate = s;
  }

  rateDelivery() {
    final doneStyle = TxtStyle()
      ..textColor(Colors.white)
      ..borderRadius(all: 5)
      ..background.color(ColorsD.main)
      ..width(100)
      ..width(size.width * 0.15)
      ..alignmentContent.center()
      ..border(color: ColorsD.main);
    final cancelStyle = TxtStyle()
      ..width(size.width * 0.15)
      ..alignmentContent.center()
      ..border(color: ColorsD.main, all:1)
      ..textColor(ColorsD.main)
      ..borderRadius(all: 5)
      ..background.color(Colors.white);
    final backGesture = Gestures()
      ..onTap(
        () {
          ExtendedNavigator.rootNavigator.pop();
        },
      );
    final doneGesture = Gestures()
      ..onTap(
        () {
          print('object');
          RM.get<OrderStore>().setState(
                (s) => s.rateDelivery(),
              );
          ExtendedNavigator.rootNavigator.pop();
        },
      );
    // final size = MediaQuery.of(ctx).size;
    return showDialog(
      context: ctx,
      builder: (context) => Dialog(
        child: Container(
          height: size.height / 5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Txt(
                  LocaleKeys.rateDelivery,
                  style: TxtStyle(),
                ),
                SmoothStarRating(
                  starCount: 5,
                  color: Colors.amber,
                  borderColor: Colors.amber,
                  onRated: getRate,
                ),
                SizedBox(height: size.height*0.024),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Txt(
                      LocaleKeys.back,
                      style: cancelStyle,
                      gesture: backGesture,
                    ),
                    SizedBox(width: size.width*0.051,),
                    Txt(
                      LocaleKeys.done,
                      style: doneStyle,
                      gesture: doneGesture,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BuildContext ctx;
  @override
  Widget build(context) {
    ctx = context;
    selectAction();
    size = MediaQuery.of(context).size;
    print(label);
    final style = TxtStyle()
      ..alignmentContent.center()
      ..borderRadius(all: 12)
      ..textColor(ColorsD.main)
      ..background.color(Colors.white)
      ..height(isPortrait(context) ? size.height / 16 : size.height / 8)
      ..width(isPortrait(context) ? size.width * 0.4 : size.width * 0.2);
    final gesture = Gestures()..onTap(callback);
    return Visibility(
        visible: label != null,
        child: Txt(label, gesture: gesture, style: style));
  }
}
