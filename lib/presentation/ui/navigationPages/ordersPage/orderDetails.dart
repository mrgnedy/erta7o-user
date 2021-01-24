import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:erta7o/data/models/order_byid_model.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/build_order_detail.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';

import 'package:erta7o/core/utils.dart';  
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/build_progress.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/order_actions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:steps_indicator/steps_indicator.dart';

class OrderDetailsPage extends StatelessWidget {
  bool unConfirmed;
  // GlobalKey progressKey = GlobalKey();

  OrderDetailsPage({Key key, this.unConfirmed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                IN.get<OrderStore>().isConfirmed = true;
                ExtendedNavigator.rootNavigator.pop();
              },
              child: Icon(Icons.arrow_back)),
          title: Txt(LocaleKeys.orderDetails),
          elevation: 0,
        ),
        body: WhenRebuilderOr<OrderStore>(
          initState: (c, rm) =>rm.state.isConfirmed? rm.setState((s) => s.showOrderByid()): rm.resetToIdle(),
          observe: () => RM.get<OrderStore>(),
          dispose: (c,m ) =>m.state.currentOrder = OrderByIdModel() ,
          builder: (context, model) => _OnData(),
          // watch: (model) => model.state.currentOrder,
          onWaiting: () => WaitingWidget(),
        ),
      ),
    );
  }
}

class _OnData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    e.printInfo(IN.get<OrderStore>().currentOrder.data.first.toJson().toString());
    return SingleChildScrollView(
      child: Center(
        heightFactor: 1.2,
        child: Column(
          children: <Widget>[
            BuildProgress(),
            BuildOrderDetaild(),
            BuildOrderActions()
          ],
        ),
      ),
    );
  }

}
