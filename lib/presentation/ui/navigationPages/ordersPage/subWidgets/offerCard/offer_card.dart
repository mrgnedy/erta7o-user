import 'package:auto_route/auto_route.dart';
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
import 'package:url_launcher/url_launcher.dart';

class OfferCard extends StatelessWidget {
  final DeliveryDetails deliveryDetails;

  const OfferCard({Key key, this.deliveryDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context.locale = Locale('ar');
    return GestureDetector(
      // onTap: () {
      //   IN.get<OrderStore>().selectedDeliveryID = deliveryDetails.id;
      //   showAcceptDialog(context);
      // },
      child: Container(
        width: size.width * 0.9,
        height: isPortrait(context) ? size.height / 3.8 : size.height / 2.8,
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Image.network(
                            '${APIs.imageBaseUrl}${deliveryDetails.image}',
                            width: size.width * 0.15,
                            height: size.width * 0.2,
                            errorBuilder: (_, __, ___) => Image.asset(
                                  R.ASSETS_IMAGES_PROFILE_PNG,
                                  width: size.width * 0.15,
                                  height: size.width * 0.2,
                                ))),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Txt(
                            '${LocaleKeys.deliverRequest.tr(
                              args: [
                                deliveryDetails.name,
                              ],
                            )}',
                            style: TxtStyle()..textColor(Colors.black),
                          ),
                          Directionality(
                            textDirection: isAr(context)
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating: num.tryParse(deliveryDetails.rate)
                                        ?.toDouble() ??
                                    0,
                                color: Colors.amber,
                                borderColor: Colors.amber),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(),
                              Txt(
                                '${LocaleKeys.price}: ${deliveryDetails.price}',
                                style: TxtStyle()
                                  ..textColor(Colors.black)
                                  ..bold(),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  launchWhatsAppBtn(deliveryDetails.phone),
                                  launchPhoneBtn(deliveryDetails.phone),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _ConfirmOfferBtn(id: deliveryDetails.id)
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

  launchPhone(url) async {
    print('object');
    if (await canLaunch('tel:$url')) {
      await launch('tel:$url');
    }
  }

  launchWhats(url) async {
    print('object');
    if (await canLaunch('https://wa.me/$url')) {
      await launch('https://wa.me/$url');
    }
  }

  Widget launchPhoneBtn(url) {
    return GestureDetector(
      onTap: () => launchPhone(url),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.phone, color: ColorsD.main),
      ),
    );
  }

  Widget launchWhatsAppBtn(url) {
    return GestureDetector(
      onTap: () => launchWhats(url),
      child: Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
    );
  }
}

class _ConfirmOfferBtn extends StatelessWidget {
  final id;
  Size size;

  _ConfirmOfferBtn({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()
      ..onTap(() {
        IN.get<OrderStore>().selectedDeliveryID = id;

        RM.get<OrderStore>().setState((s) => s.confirmDeliveryOffer(),
            onData: (context, model) => {
                  RM.get<OrderStore>().setState((s) => s.showOrderByid()),
                  ExtendedNavigator.rootNavigator.pop()
                });
      });
    size = MediaQuery.of(context).size;
    final noStyle = TxtStyle()
      ..textColor(Colors.white)
      ..alignmentContent.center()
      ..background.color(ColorsD.main)
      ..borderRadius(all: 5)
      ..alignment.center()
      ..width(isPortrait(RM.context) ? size.width * 0.2 : size.width * 0.15)
      ..height(
          isPortrait(RM.context) ? size.height * 0.051 : size.height * 0.1);
    return Txt(LocaleKeys.confirm, style: noStyle, gesture: gesture);
  }
}
