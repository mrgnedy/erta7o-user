import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/widgets/tet_field_with_title.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WhenRebuilderOr<OrderStore>(
      observe: () => RM.get<OrderStore>(),
      dispose: (c, rm) => {
        rm.state.isValidCoupon = null,
        IN.get<OrderStore>().copoun = null
      },
      builder: (context, model) => _BuildCopounOnData(),
    );
  }
}

class _BuildCopounOnData extends StatelessWidget {
  bool get isValid => IN.get<OrderStore>().isValidCoupon;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Txt(LocaleKeys.addCopoun, style: TxtStyle()..textColor(ColorsD.main)),
        Container(
          width: size.width * 0.45,
          height: size.height / 16,
          margin: EdgeInsets.only(top: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black, height: 1.5),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.zero),
                  onChanged: (s) {
                    IN.get<OrderStore>().copoun = s;
                  },
                ),
              ),
              Expanded(child: CheckCoupon()),
            ],
          ),
        ),
        Visibility(
          visible: isValid != null,
          child: Txt(
            isValid == true
                ? LocaleKeys.copounAdded
                : isValid == false ? LocaleKeys.wrongCopoun : '',
            style: TxtStyle()
              ..textColor(isValid == true ? Colors.green : Colors.red),
          ),
        )
      ],
    );
  }
}

class CheckCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      builder: (context, model) => _CheckCouponOnData(),
      onWaiting: () => WaitingWidget(color: ColorsD.main),
      observe: () => RM.get<RestaurantsStore>(),
    );
  }
}

class _CheckCouponOnData extends StatelessWidget {
  final checkStyle = TxtStyle()
    ..borderRadius(all: 5)
    ..background.color(ColorsD.main)
    ..textColor(Colors.white)
    ..margin(horizontal: 5)
    ..textAlign.center()
    ..alignmentContent.center();
  final gesture = Gestures()
    ..onTap(() {
      RM.get<OrderStore>().setState((s) => s.chechCopoun(),
          onData: (context, model) {
        model.isValidCoupon = true;
      }, onError: (context, model) {
        IN.get<OrderStore>().isValidCoupon = false;
      });
    });
  @override
  Widget build(BuildContext context) {
    return Txt(LocaleKeys.check, style: checkStyle, gesture: gesture);
  }
}
