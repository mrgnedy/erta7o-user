import 'package:erta7o/data/models/delivery_offers.dart';
import 'package:erta7o/data/models/order_model.dart';
import 'package:erta7o/data/models/orders_model.dart';
import 'package:erta7o/data/models/restaurants_model.dart';
import 'package:erta7o/data/models/order_byid_model.dart';
import 'package:erta7o/data/repository/order_repo.dart';

class OrderStore {
  final OrderRepo orderRepo;
  bool isConfirmed = true;
  OrderByIdModel currentOrder;
  int currentOrderId;
  bool isValidCoupon;
  String copoun;
  RestaurantsModel allRestaurants;
  OrderProductModel orderProductModel =
      OrderProductModel(products: [Product()]);
  OrderModel orderModel = OrderModel(
    orderProductModel: OrderProductModel(products: []),
  );
  DeliveryOffersModel deliveryOffersModel;
  // DeliveryDetails currentDelivery;
  OrderStore(this.orderRepo);
  OrdersModel initialOrders;
  OrdersModel finishedOrders;
  int selectedDeliveryID;
  int currentOrderTab = 0;
  List<OrdersModel> get ordersList => [
        initialOrders,
        finishedOrders,
      ];
  List<Future<OrdersModel>> get getOrdersList => [
        getInitOrders(),
        getFinishedOrders(),
      ];

  double rate;

  Future makeOrder() async {
    final temp = await orderRepo.makeOrder(
        (orderModel..orderProductModel = orderProductModel).toJson());
    isConfirmed = true;
    return temp;
  }

  Future chechCopoun() async {
    return await orderRepo.checkCopoun(copoun);
  }

  Future finishOrder() async {
    return await orderRepo.finishOrder(currentOrder.data.first.order.id);
  }

  Future<OrdersModel> getInitOrders() async {
    final temp = OrdersModel.fromJson(await orderRepo.getInitialOrders());
    initialOrders = temp;
    // currentOrder = temp.data.last;
    return temp;
  }

  Future<OrdersModel> getFinishedOrders() async {
    final temp = OrdersModel.fromJson(await orderRepo.getFinishedOrders());
    finishedOrders = temp;
    return temp;
  }

  Future<DeliveryOffersModel> getDeliveryOffers() async {
    deliveryOffersModel =
        DeliveryOffersModel.fromJson(await orderRepo.getDeliveryOffers());
    return deliveryOffersModel
      ..data = deliveryOffersModel.data
          .where(
              (element) => element.orderId == currentOrder.data.first.order.id)
          .toList();
  }

  Future confirmDeliveryOffer() async {
    return await orderRepo.confirmOffer(selectedDeliveryID);
  }

  Future<OrderByIdModel> showOrderByid() async {
    final temp = OrderByIdModel.fromJson(
      await orderRepo.showOrderByID(currentOrderId),
    );
    currentOrder = temp;
    return currentOrder;
  }

  Future rateDelivery() async {
    return await orderRepo.rateDelivery(
      currentOrder.data.first.order.deliveryId,
      rate,
    );
  }
}
