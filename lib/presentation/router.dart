import 'package:auto_route/auto_route_annotations.dart';
import 'package:erta7o/presentation/ui/mainPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:erta7o/presentation/widgets/map.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  MainUserPage mainUserPage;
  RestaurantDetails restaurantDetails;
  MenuPage menuPage;
  ProductDetailsPage productDetailsPage;
  MapScreen mapScreen;
}
