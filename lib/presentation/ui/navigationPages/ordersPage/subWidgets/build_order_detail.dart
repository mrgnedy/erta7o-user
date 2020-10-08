import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/data/models/order_byid_model.dart';
import 'package:request_mandoub/data/models/order_model.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildOrderDetaild extends StatelessWidget {
  OrderByIdModel get confirmedOrder => IN.get<OrderStore>().currentOrder;
  // OrderModel get unConfirmedOrder => IN.get<OrderStore>().orderModel;
  bool get isConfirmed => IN.get<OrderStore>().isConfirmed;
  @override
  Widget build(BuildContext context) {
    // return hhfb;
    // return isConfirmed
    //     ? buildConfirmedDetails(context)
    //     : buildUnConfirmedDetails();
    return buildConfirmedDetails(context);
  }

  Widget buildConfirmedDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [buildProductsDetails(context), buildOrderDetails(context)],
      ),
    );
  }

  List get statusList => IN.get<OrderStore>().statusList;
  Widget buildProductsDetails(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        confirmedOrder.data.first.menus.length,
        (index) {
          final currentProduct = confirmedOrder.data.first.menus[index];
          List<Map<String, dynamic>> producrDetailList = [
            {
              LocaleKeys.sandwitchName:
                  '${isAr(context) ? currentProduct.menuAr : currentProduct.menuEn}'
            },
            {
              LocaleKeys.sandwitchType:
                  '${statusList[currentProduct.type.clamp(0, 1)]}'
            },
            {LocaleKeys.qty: '${currentProduct.quantity}'},
            {LocaleKeys.additions: '${currentProduct.addittions}'},
            {LocaleKeys.price: '${currentProduct.price}'},
          ];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: List.generate(
                    producrDetailList.length,
                    (index) {
                      final key = producrDetailList[index].keys.first;
                      String value = producrDetailList[index][key];
                      value = key == LocaleKeys.price
                          ? LocaleKeys.priceTag.tr(args: [value])
                          : value;

                      return StylesD.richText(
                          mainText: key,
                          locale: context.locale,
                          subText: value == null || value.isEmpty
                              ? 'لا يوجد'
                              : value,
                          width: size.width);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildOrderDetails(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orderDetails = confirmedOrder.data.first.order;
    final products = confirmedOrder.data.first.menus;
    final price = List<num>.generate(products.length, (index) {
      return products[index].price ??
          0 * int.tryParse(products[index].quantity);
    }).reduce((value, element) => value + element);
    List<Map<String, dynamic>> orderDetailList = [
      {LocaleKeys.address: orderDetails.address},
      {LocaleKeys.deliveryTime: orderDetails.time},
      {LocaleKeys.deliveryName: orderDetails.delivery},
      {LocaleKeys.totalPrice: orderDetails.totalPrice ?? '$price'},
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: orderDetailList.map((e) {
              final String key = e.keys.first;
              String value = e[key];
              value = key == LocaleKeys.totalPrice
                  ? LocaleKeys.priceTag.tr(args: [value])
                  : value;
              value = key == LocaleKeys.deliveryTime
                  ? "$value ${LocaleKeys.hour}"
                  : value;
              return value == null || value.contains('null')
                  ? Container()
                  : StylesD.richText(
                      mainText: key,
                      locale: context.locale,
                      subText: value,
                      width: size.width);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
