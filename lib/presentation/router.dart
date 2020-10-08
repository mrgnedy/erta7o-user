import 'package:auto_route/auto_route_annotations.dart';
import 'package:request_mandoub/presentation/ui/authPages/authPage.dart';
import 'package:request_mandoub/presentation/ui/authPages/forget_password.dart';
import 'package:request_mandoub/presentation/ui/authPages/rechange_pw.dart';
import 'package:request_mandoub/presentation/ui/authPages/verifyPage.dart';
import 'package:request_mandoub/presentation/ui/drawerPages/about_page.dart';
import 'package:request_mandoub/presentation/ui/drawerPages/contact_us.dart';
import 'package:request_mandoub/presentation/ui/mainPage/mainPage.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/ordersPage/offers_page.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/ordersPage/orderDetails.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/menuPage.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/productDetails/productDetails.dart';
import 'package:request_mandoub/presentation/ui/restaurantDetails/restaurantDetails.dart';
import 'package:request_mandoub/presentation/ui/splash_screen.dart';
import 'package:request_mandoub/presentation/widgets/map.dart';

@MaterialAutoRouter()
class $Router {
  MainUserPage mainUserPage;
  @initial
  SplashScreen splashScreen;
  AuthPage authPage;
  VerifyPage verifyPage;
  ForgetPassword forgetPassword;
  RestaurantDetails restaurantDetails;
  MenuPage menuPage;
  ProductDetailsPage productDetailsPage;
  MapScreen mapScreen;
  OrderDetailsPage orderDetailsPage;
  OffersPage offersPage;
  AboutPage aboutPage;
  ContactUs contactUs;
  RechangePWPage rechangePWPage;
}
