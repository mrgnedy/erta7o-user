import 'package:erta7o/core/api_utils.dart';

class RestaurantsRepo {
  Future getHome() async {
    String url = APIs.homeEP;
    return await APIs.getRequest(url);
  }

  Future getNearest() async {
    String url = APIs.nearestEP;
    return await APIs.getRequest(url);
  }

  Future getWanted() async {
    String url = APIs.wantedEP;
    return await APIs.getRequest(url);
  }

  Future getRestaurantByID(id) async {
    String url = APIs.showRestoEP;
    Map<String, dynamic> body = {"restaurant_id": "$id"};
    return await APIs.postRequest(url, body);
  }

  Future getProductByID(id) async {
    String url = APIs.showProductEP;
    Map<String, dynamic> body = {"product_id": "$id"};
    return await APIs.postRequest(url, body);
  }

 
}
