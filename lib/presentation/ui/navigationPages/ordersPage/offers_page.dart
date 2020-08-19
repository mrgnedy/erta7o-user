import 'package:division/division.dart';
import 'package:erta7o/data/models/delivery_offers.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/subWidgets/offerCard/offer_card.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Txt(LocaleKeys.deliveryOffers),
          centerTitle: true,
          elevation: 0,
        ),
        body: WhenRebuilderOr<OrderStore>(
          initState: (c,rm)=> rm.setState((s) => s.getDeliveryOffers()),
          observe: ()=>RM.get<OrderStore>(),
          builder: (context, model) => _BuildBody(),
          onWaiting: () => IN.get<OrderStore>().deliveryOffersModel == null
              ? WaitingWidget()
              : _BuildBody(),
        ),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  List<DeliveryDetails> get deliveryOffers => IN.get<OrderStore>().deliveryOffersModel.data;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: List.generate(deliveryOffers.length, (index) {
          return OfferCard(deliveryDetails: deliveryOffers[index]);
        }),
      ),
    ));
  }
}
