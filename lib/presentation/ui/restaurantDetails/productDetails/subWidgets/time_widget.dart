import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildTime extends StatelessWidget {
  int hrsCount = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = ParentStyle()
      ..border(all: 1, color: ColorsD.main)
      ..borderRadius(all: 8)
      ..padding(all: 0)
      ..width(size.width * 0.45)
      ..height(size.height / 16);
    return StatefulBuilder(builder: (context, setState) {
      Function addOnTap = () {
        setState(() => hrsCount++);
        IN.get<OrderStore>().orderModel.time = hrsCount.toString();
      };
      Function removeOnTap = hrsCount <= 1
          ? null
          : () {
              setState(() => hrsCount--);
              IN.get<OrderStore>().orderModel.time = hrsCount.toString();
            };
      return Column(
        children: <Widget>[
          Txt(
            LocaleKeys.chooseTime,
            style: TxtStyle()..textColor(ColorsD.main),
          ),
          Parent(
            style: style,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    onPressed: removeOnTap,
                    icon: Icon(Icons.remove),
                    color: ColorsD.main),
                Txt(
                  "$hrsCount ساعة",
                  style: TxtStyle()..textColor(ColorsD.main),
                ),
                IconButton(
                  onPressed: addOnTap,
                  alignment: Alignment.center,
                  icon: Icon(Icons.add),
                  color: ColorsD.main,
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
