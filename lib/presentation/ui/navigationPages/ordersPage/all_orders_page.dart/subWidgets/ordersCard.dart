import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/orders_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/mainPage/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../../../router.gr.dart';

class OrderCard extends StatelessWidget {
  final OrderDetail order;
  Size size;

  OrderCard({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(context.locale.languageCode);
    size = MediaQuery.of(context).size;
    return Align(
      child: InkWell(
        onTap: () {
          IN.get<OrderStore>().currentOrderId = order.id;
          ExtendedNavigator.rootNavigator.pushNamed(Routes.orderDetailsPage);
        },
        child: Container(
          width: size.width * 0.8,
          height: size.height / 5.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildImage(),
                  buildDetails(context),
                  Container()
                ],
              ),
              Align(
                  alignment: context.locale == Locale('ar')
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: buildActions()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Expanded(
        flex: 1, child: Image.network('${APIs.imageBaseUrl}${order.image}'));
  }

  Widget buildDetails(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Txt("${context.locale == Locale('ar') ? order.restaurantAr : order.restaurantEn}",
              style: TxtStyle()..textColor(Colors.black)),
          buildDetailRow(LocaleKeys.deliveryTime + order.time.split(':').first,
              R.ASSETS_IMAGES_TIME_PNG),
          buildDetailRow(
              '${LocaleKeys.deliveryName} : ${order.delivery.isEmpty ? "لم يحدد بعد" : order.delivery}',
              R.ASSETS_IMAGES_DELIVERY_PNG)
          // buildDetailRow(),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, [String asset]) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 4),
          child: Image.asset(
            asset ?? R.ASSETS_IMAGES_NOTIFICATION_PNG,
            color: ColorsD.main,
            width: size.width / 25,
          ),
        ),
        Txt(
          label,
          style: TxtStyle()
            ..width(size.width / 3.5)
            ..maxLines(null)
            ..textColor(Colors.black)
            ..fontSize(10)
            ..maxLines(2),
        )
      ],
    );
  }

  Widget buildActions() {
    int statusIndex = order?.status == null || order?.status?.isEmpty
        ? 0
        : int.tryParse(order?.status);
    String status = IN.get<OrderStore>().progressList[statusIndex];
    return Container(
      // width: size.width * 0.2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
              onTap: deleteOrder,
              child: Icon(Icons.delete_outline, color: Colors.red)),
          Txt(
            status,
            style: TxtStyle()
              ..textColor(Colors.green)
              ..maxLines(2)
              ..textAlign.center(),
          )
        ],
      ),
    );
  }

  deleteOrder() {
    RM.get<OrderStore>().setState(
          (s) => s.deleteOrder(order.id).then(
                (value) => s.getOrdersList[s.currentOrderTab],
              ),
        );
  }
}
