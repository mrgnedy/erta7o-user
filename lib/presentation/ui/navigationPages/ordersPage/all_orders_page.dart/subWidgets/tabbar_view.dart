import 'package:auto_route/auto_route.dart';
import 'package:erta7o/data/models/orders_model.dart';
import 'package:erta7o/presentation/router.gr.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'ordersCard.dart';

class BuildOrdersList extends StatelessWidget {
  OrdersModel get orders =>
      IN.get<OrderStore>().ordersList[IN.get<OrderStore>().currentOrderTab];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: orders.data.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => OrderCard(order: orders.data[index]),
      ),
    );
  }
}
