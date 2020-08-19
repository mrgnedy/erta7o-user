import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/subWidgets/tab_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = [LocaleKeys.activeOrders, LocaleKeys.finishedOrders];
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 15,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: List.generate(
          list.length,
          (index) => TabBtn(label: list[index], index: index),
        ),
      ),
    );
  }
}