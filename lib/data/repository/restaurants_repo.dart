import 'package:request_mandoub/core/api_utils.dart';
import 'package:request_mandoub/presentation/state/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RestaurantsRepo {
  Future getHome() async {
    String url = IN.get<AuthStore>().isAuth ? APIs.homeEP : APIs.unauthhomeEP;
    print('${url == APIs.homeEP ? 'Getting auth home' : 'Getting unauthHome'}');
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

  Future rateRestaurant(rate, id) async {
    String url = APIs.addrestaurantrateEP;
    Map<String, dynamic> body = {"restaurant_id": "$id", "rate": "$rate"};
    return await APIs.postRequest(url, body);
  }
}
