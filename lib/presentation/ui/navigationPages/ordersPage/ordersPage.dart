import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/ordersCard.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Size get size => MediaQuery.of(super.context).size;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        buildTabs(),
        FractionallySizedBox(widthFactor: 0.1),
        buildOrdersList()
      ],
    );
  }

  Widget buildTabs() {
    return Container(
      height: size.height/15,
      width: size.width*0.8,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(child: Txt(LocaleKeys.activeOrders,style: TxtStyle()..fontSize(20)..textColor(Colors.white),)),
          ),
          VerticalDivider(thickness: 1, color: Colors.white),
          Expanded(
            child: Center(child: Txt(LocaleKeys.finishedOrders,style: TxtStyle()..fontSize(20)..textColor(Colors.grey))),
          ),
        ],
      ),
    );
  }

  Widget buildOrdersList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        itemBuilder: (_, __) => OrderCard(),
      ),
    );
  }
}
