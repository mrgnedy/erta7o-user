import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class TabBtn extends StatelessWidget {
  final String label;
  final int index;

  const TabBtn({Key key, this.label, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            RM.get<OrderStore>().setState((s) => s.currentOrderTab = index),
        child: Center(
          child: Txt(
            label,
            style: TxtStyle()
              ..fontSize(20)
              
              ..textColor(index==IN.get<OrderStore>().currentOrderTab? Colors.white: Colors.grey)
              ..textAlign.center(),
          ),
        ),
      ),
    );
  }
}
