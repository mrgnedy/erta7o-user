import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/const/resource.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/data/models/notification_model.dart';
import 'package:request_mandoub/presentation/router.gr.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/state/setting_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class NotificationCard extends StatelessWidget {
  final int index;
  final style = TxtStyle()
    ..textColor(Colors.black)
    ..textOverflow(TextOverflow.ellipsis)
    ..maxLines(2);
  final styleSec = TxtStyle()..textColor(Colors.grey[800]);
  NotificationDetail get notificationDetail =>
      IN.get<SettingStore>().notificationModel.data[index];
  NotificationCard({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => RM.get<SettingStore>().setState(
            (s) => s
                .delNotifications(notificationDetail.id)
                .then((value) => s.getNotifications()),
          ),
      child: GestureDetector(
        onTap: () {
          if (notificationDetail.type == 5)
            StylesD.rateDelivery(context, confirmRate);
          else if (notificationDetail.type == 4) {
            IN.get<OrderStore>().currentOrderId = notificationDetail.orderID;
            ExtendedNavigator.rootNavigator.pushNamed(Routes.orderDetailsPage);
          }
        },
        child: Container(
          width: size.width * 0.8,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(R.ASSETS_IMAGES_NOTIFICATION_PNG),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Txt('${notificationDetail.body}', style: style),
                    Txt(
                      '${notificationDetail.createdAt}',
                      style: styleSec,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmRate(rate) {
    RM.get<RestaurantsStore>().setState(
        (s) => s.rateRestaurant(rate, notificationDetail.restaurantID));
  }
}
