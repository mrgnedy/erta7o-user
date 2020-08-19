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
  final OrderDetail  order;
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
              ExtendedNavigator.rootNavigator
                  .pushNamed(Routes.orderDetailsPage);
            },
              child: Container(
          width: size.width * 0.8,
          height: size.height / 6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              buildImage(),
              buildDetails(context),
              buildActions(),
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
          Txt("${context.locale.countryCode == 'en' ? order.restaurantAr : order.restaurantEn}",
              style: TxtStyle()..textColor(Colors.black)),
          buildDetailRow(order.time),
          buildDetailRow(order.delivery),
          // buildDetailRow(),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, [String asset]) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 5),
          child: Image.asset(R.ASSETS_IMAGES_NOTIFICATION_PNG),
        ),
        Txt(
          LocaleKeys.deliveryTime,
          style: TxtStyle()
            ..textColor(Colors.black)
            ..fontSize(10),
        )
      ],
    );
  }

  Widget buildActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(Icons.delete_outline, color: Colors.red),
        Txt(
          LocaleKeys.orderWaiting,
          style: TxtStyle()..textColor(Colors.green),
        )
      ],
    );
  }
}
