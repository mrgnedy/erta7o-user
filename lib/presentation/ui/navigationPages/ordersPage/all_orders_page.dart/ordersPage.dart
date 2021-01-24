import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/subWidgets/tab_btn.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/subWidgets/ordersCard.dart';
import 'package:erta7o/presentation/widgets/error_widget.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'subWidgets/tab_bar.dart';
import 'subWidgets/tabbar_view.dart';

class OrdersPage extends StatelessWidget {
  ReactiveModel get rm => RM.get<OrderStore>();
  OrderStore get orderStore => IN.get<OrderStore>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WhenRebuilderOr<OrderStore>(
          initState: (c, rm) => rm.setState(
            (s) => s.getOrdersList[s.currentOrderTab],
          ),
          observe: () => rm,
          onWaiting: () =>
              orderStore.ordersList[orderStore.currentOrderTab] == null
                  ? WaitingWidget()
                  : buildBody(),
          onError: (error) =>
              orderStore.ordersList[orderStore.currentOrderTab] == null
                  ? OnErrorWidget('لا توجد طلبات')
                  : buildBody(),
          builder: (context, model) => buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => RM.get<OrderStore>().setState(
            (s) => s.getOrdersList[s.currentOrderTab],
          )),
      child: Column(
        children: <Widget>[
          BuildTabBar(),
          FractionallySizedBox(widthFactor: 0.1),
          BuildOrdersList()
        ],
      ),
    );
  }
}
