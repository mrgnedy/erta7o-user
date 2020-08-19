import 'package:erta7o/core/api_utils.dart';

class OrderRepo{
   Future makeOrder(Map<String, dynamic> body) async {
    String url = APIs.makeOrderEP;
    return await APIs.postRequest(url, body);
  }

  Future checkCopoun(copoun) async {
    String url = APIs.checkcoponEP;
    Map<String, dynamic> body = {'code': '$copoun'};
    return await APIs.postRequest(url, body);
  }
  Future finishOrder(delID) async {
    String url = APIs.finishorderEP;
    Map<String, dynamic> body = {'delivery_id': '$delID'};
    return await APIs.postRequest(url, body);
  }
  Future getInitialOrders() async {
    String url = APIs.userinitordersEP;
    return await APIs.getRequest(url);
  }
  Future getFinishedOrders() async {
    String url = APIs.userfinishordersEP;
    return await APIs.getRequest(url);
  }
  Future getDeliveryOffers() async {
    String url = APIs.deliveryoffersEP;
    return await APIs.getRequest(url);
  }
  Future rateDelivery(deliveryID, rate) async {
    String url = APIs.adddeliveryrateEP;
    Map<String, dynamic> body = {'delivery_id': '$deliveryID', "rate" : "$rate"};
    return await APIs.postRequest(url, body);
  }
  Future confirmOffer(deliveryID) async {
    String url = APIs.confirmOfferEP;
    Map<String, dynamic> body = {'delivery_id': '$deliveryID'};
    return await APIs.postRequest(url, body);
  }
  Future showOrderByID(orderID) async {
    String url = APIs.showOrderEP;
    Map<String, dynamic> body = {'order_id': '$orderID'};
    return await APIs.postRequest(url, body);
  }
}