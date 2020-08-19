import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/delivery_offers.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/offerCard/confirm_order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:states_rebuilder/states_rebuilder.dart';

class OfferCard extends StatelessWidget {
  final DeliveryDetails deliveryDetails;

  const OfferCard({Key key, this.deliveryDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context.locale = Locale('ar');
    return GestureDetector(
      onTap: () {
        IN.get<OrderStore>().selectedDeliveryID = deliveryDetails.id;
        showAcceptDialog(context);
      },
      child: Container(
        width: size.width * 0.8,
        height: isPortrait(context) ? size.height / 6 : size.height / 3,
        child: Card(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Image.network(
                        '${APIs.imageBaseUrl}${deliveryDetails.image}',
                        errorBuilder: (_, __, ___) =>
                            Image.asset(R.ASSETS_IMAGES_USER_PNG))),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Txt(
                        '${deliveryDetails.name} يريد توصيل طلبك بقيمة 20 ريال',
                        style: TxtStyle()..textColor(Colors.black),
                      ),
                      Directionality(
                        textDirection: isAr(context)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: num.tryParse(deliveryDetails.rate) ?? 0,
                            color: Colors.amber,
                            borderColor: Colors.amber),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Txt(
                            '2 دقيقة',
                            style: TxtStyle()..textColor(Colors.black),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.whatsapp,
                                  color: Colors.green),
                              Icon(Icons.phone, color: ColorsD.main),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAcceptDialog(context) async {
    final size = MediaQuery.of(context).size;
    final contentStyle = TxtStyle()
      ..textColor(ColorsD.main)
      ..alignmentContent.center()
      ..fontSize(18);

    return await showDialog(
      context: context,
      builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: isPortrait(context) ? size.height / 6 : size.height / 3,
            width: size.width * 0.5,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Txt(LocaleKeys.acceptOffer, style: contentStyle),
                  ConfirmOfferBtn()
                ],
              ),
            ),
          )),
    );
  }
}

class _ConfirmOfferBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
