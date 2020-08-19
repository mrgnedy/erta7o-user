import 'package:auto_route/auto_route_annotations.dart';
import 'package:erta7o/presentation/ui/authPages/authPage.dart';
import 'package:erta7o/presentation/ui/authPages/forget_password.dart';
import 'package:erta7o/presentation/ui/authPages/verifyPage.dart';
import 'package:erta7o/presentation/ui/mainPage/mainPage.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/offers_page.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/orderDetails.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/productDetails/productDetails.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:erta7o/presentation/widgets/map.dart';

@MaterialAutoRouter()
class $Router {
  MainUserPage mainUserPage;
  @initial
  AuthPage authPage;
  VerifyPage verifyPage;
  ForgetPassword forgetPassword;
  RestaurantDetails restaurantDetails;
  MenuPage menuPage;
  ProductDetailsPage productDetailsPage;
  MapScreen mapScreen;
  OrderDetailsPage orderDetailsPage;
  OffersPage offersPage;
}
