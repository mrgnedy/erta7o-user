import 'package:erta7o/data/models/order_model.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/data/models/restaurants_model.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/data/repository/restaurants_repo.dart';
import 'package:flutter/cupertino.dart';

class RestaurantsStore {
  final RestaurantsRepo restaurantsRepo;
  UserHomeModel userHomeModel;
  RestaurantModel currentRestaurant;
  Products currentProduct;
  int currentRestoID;
  RestaurantsModel nearestRestaurants;
  RestaurantsModel wantedRestaurants;
  int selectedFilter = 0;
  RestaurantsModel allRestaurants;

  List<RestaurantsModel> get allHomeFilters =>
      [allRestaurants, wantedRestaurants, nearestRestaurants];

  RestaurantsModel get currentFilter => allHomeFilters[selectedFilter];

  List<Future> get filterRequests => [getHome(), getWanted(), getNearest()];
  Future get getCurrentFilter => filterRequests[selectedFilter];

  RestaurantsStore(this.restaurantsRepo);

  Future<UserHomeModel> getHome() async {
    userHomeModel = UserHomeModel.fromJson(await restaurantsRepo.getHome());
    allRestaurants = RestaurantsModel(data: userHomeModel.data.restaurants);
    return userHomeModel;
  }

  Future<RestaurantsModel> getNearest() async {
    nearestRestaurants =
        RestaurantsModel.fromJson(await restaurantsRepo.getNearest());
    return nearestRestaurants;
  }

  Future<RestaurantsModel> getWanted() async {
    wantedRestaurants =
        RestaurantsModel.fromJson(await restaurantsRepo.getWanted());
    return wantedRestaurants;
  }

  Future<RestaurantModel> getRestaurant() async {
    currentRestaurant = RestaurantModel.fromJson(
        await restaurantsRepo.getRestaurantByID(currentRestoID));
    return currentRestaurant;
  }

  Future rateRestaurant(rate, restID) async {
    return await restaurantsRepo.rateRestaurant(rate, restID);
  }

  // Future<Prpduc> getProduct() async {
  //   currentProduct = RestaurantModel.fromJson(
  //       await restaurantsRepo.getProductByID(currentRestoID));
  //   return currentRestaurant;
  // }

}
