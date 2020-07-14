import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderCard extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    // print(context.locale.languageCode);
    size = MediaQuery.of(context).size;
    return Align(
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
            buildDetails(),
            buildActions(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Expanded(flex: 1, child: Image.network(dummyImageList.first));
  }

  Widget buildDetails() {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Txt("Burger King", style: TxtStyle()..textColor(Colors.black)),
          buildDetailRow(),
          buildDetailRow(),
          buildDetailRow(),
        ],
      ),
    );
  }

  Widget buildDetailRow() {
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
