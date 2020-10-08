import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/data/models/orders_model.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/router.gr.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart';

import 'ordersCard.dart';

class BuildOrdersList extends StatelessWidget {
  List<String> list = [LocaleKeys.activeOrders, LocaleKeys.finishedOrders];
  String get title => list[IN.get<OrderStore>().currentOrderTab];
  OrdersModel get orders =>
      IN.get<OrderStore>().ordersList[IN.get<OrderStore>().currentOrderTab];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: orders.data.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Txt(LocaleKeys.noOrders.tr(args: [title])),
                  InkWell(
                      onTap: () {
                        RM.get<OrderStore>().setState(
                              (s) => s.getOrdersList[s.currentOrderTab],
                            );
                      },
                      child: Icon(Icons.refresh, color: Colors.grey, size: 45)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.data.length,
              shrinkWrap: true,
              itemBuilder: (_, index) => OrderCard(order: orders.data[index]),
            ),
    );
  }
}
