// import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:request_mandoub/const/resource.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/auth_store.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:request_mandoub/presentation/ui/drawerPages/drawer.dart';
import 'package:request_mandoub/presentation/ui/mainPage/subWidgets/filters.dart';
import 'package:request_mandoub/presentation/ui/mainPage/subWidgets/restaurants.dart';
import 'package:request_mandoub/presentation/ui/mainPage/subWidgets/slider.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/homePage/home_page.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/homePage/subWidgets/app_bar.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/notificationPage/notification_page.dart';
import 'package:request_mandoub/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/ordersPage.dart';
import 'package:request_mandoub/presentation/widgets/FCM.dart';
import 'package:request_mandoub/presentation/widgets/auction_card.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:request_mandoub/presentation/widgets/map.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../router.gr.dart';
import '../navigationPages/homePage/subWidgets/bottom_navigation.dart';
import '../navigationPages/profilePage/profile_page.dart';

class MainUserPage extends StatefulWidget {
  final int page;

  const MainUserPage({Key key, this.page}) : super(key: key);
  @override
  _MainUserPageState createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage>
    with SingleTickerProviderStateMixin {
  Size size;
  Size searchBarSize = Size(100, 100);

  AnimationController animationController;
  Animation<Size> searchBarAnim;
  Animation<double> searchAnim;
  FocusNode searchCatNode = FocusNode();
  GlobalKey bottomNavKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageCtrler = PageController()
      ..addListener(() {
        // print('currentPage is: ${pageCtrler.page.toInt()}');
        currentPage = pageCtrler.page.toInt();
        bottomNavKey.currentState.setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.page != null) pageCtrler.jumpToPage(widget.page);
    });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    searchAnim = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
      curve: Curves.easeInCubic,
      parent: animationController,
    ));
    FirebaseNotifications.handler(onMessage, onLaunch, onResume);
  }

  onMessage(msg) {
    print('helooooo');
    Future.delayed(Duration(milliseconds: 100), () {
      // print()
      FlutterRingtonePlayer.playNotification();
      try {
        Flushbar(
            animationDuration: Duration(milliseconds: 200),
            duration: Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            borderRadius: 12,
            routeBlur: 10,
            routeColor: Colors.grey,
            title: '${msg['title']}',
            message: '${msg['body']}',
            onTap: (flushbar) {
              ExtendedNavigator.rootNavigator
                  .popUntil(ModalRoute.withName(Routes.mainUserPage));
              print('Is current route');
              Future.delayed(Duration(milliseconds: 500), () {
                pageCtrler.animateToPage(2,
                    duration: Duration(seconds: 1), curve: Curves.easeInCubic);
              });
            })
          ..show(context);
      } catch (e) {
        print(e);
      }
    });
  }

  onLaunch(msg) {
    // Future.delayed(Duration(milliseconds: 100), () {
    //   ExtendedNavigator.rootNavigator.pushNamed(Routes.contactUs);
    // });
  }

  onResume(msg) {
    // Future.delayed(Duration(milliseconds: 100), () {
    //   ExtendedNavigator.rootNavigator.pushNamed(Routes.contactUs);
    // });
  }

  PageController pageCtrler;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print(IN.get<AuthStore>().credentialsModel?.apiToken);
    // context.locale = Locale('ar');
    size = MediaQuery.of(context).size;
    searchBarSize = Size(size.width * 0.5, size.height / 12);
    searchBarAnim = SizeTween(begin: Size(50, 100), end: searchBarSize)
        .animate(CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    ));
    return WillPopScope(
      onWillPop: ()=> Future.sync(() => false),
          child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerMenu(),
          backgroundColor: ColorsD.main,
          bottomNavigationBar: IN.get<AuthStore>().isAuth
              ? StatefulBuilder(
                  key: bottomNavKey,
                  builder: (context, setState) {
                    return BottomNavBar(
                        currentPage: currentPage, pageController: pageCtrler);
                  })
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              IN.get<AuthStore>().isAuth ? buildActionBtn() : null,
          appBar: HomeAppBar(scaffoldKey: _scaffoldKey, height: size.height / 12),
          body: PageView(
            controller: pageCtrler,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              OrdersPage(),
              NotificationPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }

  // PageController indicatorCtrler = PageController();
  // Widget buildBody() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: <Widget>[
  //         BuildSlider(),
  //         BuildFilters(),
  //         BuildRestaurantsCards()
  //       ],
  //     ),
  //   );
  // }

  Widget buildAppBar({GlobalKey<ScaffoldState> scaffoldKey}) {
    return PreferredSize(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  child: Image.asset(R.ASSETS_IMAGES_MENU_PNG),
                  onTap: () => scaffoldKey.currentState.openDrawer()),
              Txt(LocaleKeys.main,
                  style: TxtStyle()
                    ..fontSize(26)
                    ..textColor(Colors.white)),
              Row(
                children: <Widget>[
                  animatedSearchWidget(),
                  searchByLocation(),
                ],
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(size.height / 12));
  }

  Widget animatedSearchWidget() {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            width: searchBarAnim.value.width,
            height: size.height / 8,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Opacity(
                    opacity: (searchBarAnim.value.width - 50) /
                        (searchBarSize.width - 50),
                    child: searchWidget()),
                Align(
                  alignment: FractionalOffset(
                      context.locale == Locale('ar') ? 0 : 1, 0.15),
                  child: IconButton(
                    onPressed: () => setState(() {
                      if (animationController.isCompleted)
                        animationController.reverse();
                      else {
                        animationController.forward();
                        FocusScope.of(context).requestFocus(searchCatNode);
                      }
                    }),
                    icon: Transform.rotate(
                        // alignment: FractionalOffset(-1, 0),
                        angle: searchAnim.value,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget searchWidget() {
    return TypeAheadFormField(
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          constraints: BoxConstraints.tightFor(width: size.width * 0.5),
          hasScrollbar: true,
          borderRadius: BorderRadius.circular(12)),
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: searchCatNode,
        // controller: searchCatCtrler,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'bein', height: 1),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onSuggestionSelected: (cat) => setState(() {
        // selectedCatID = cat.id.toString();
        // searchCatCtrler.text = cat.name;
        animationController.reverse();
      }),
      itemBuilder: (_, cat) => Txt(
        '${cat.name}',
        style: TxtStyle()
          ..textAlign.center()
          ..width(size.width * 0.5)
          ..textColor(Colors.black)
          ..padding(bottom: 5),
      ),
      suggestionsCallback: (suggestion) => Future.sync(() => []),
    );
  }

  Widget searchByLocation() {
    return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: MapScreen(),
            ),
          );
        },
        child: Icon(Icons.location_on));
  }
  // filterByLocation(LatLng latLng){
  //   RM.get<RestaurantsStore>().state.allRestaurants.data.takeWhile((value) => Geolocator().distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)
  // }

  int currentPage = 0;
  // Widget buildBottomSheet() {
  //   List<Map<String, String>> navigationAssets = [
  //     {'asset': R.ASSETS_IMAGES_STORE_PNG, "label": LocaleKeys.mainNav},
  //     {'asset': R.ASSETS_IMAGES_DELIVERY_PNG, "label": LocaleKeys.ordersNav},
  //     {
  //       'asset': R.ASSETS_IMAGES_NOTIFICATION_PNG,
  //       "label": LocaleKeys.notificationNav
  //     },
  //     {'asset': R.ASSETS_IMAGES_USER_PNG, "label": LocaleKeys.accountNav},
  //   ];

  //   // showModalBottomSheet(context: null, builder: null, )
  //   return BottomAppBar(
  //     // onTap: (p) => setState(() => currentPage = p),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: List.generate(
  //         navigationAssets.length,
  //         (index) {
  //           final padding = index == 2
  //               ? context.locale == Locale('en')
  //                   ? EdgeInsets.only(left: 20)
  //                   : EdgeInsets.only(right: 20)
  //               : index == 1
  //                   ? context.locale == Locale('en')
  //                       ? EdgeInsets.only(right: 20)
  //                       : EdgeInsets.only(left: 20)
  //                   : EdgeInsets.zero;
  //           return InkWell(
  //             onTap: () => setState(() => currentPage = index),
  //             // title: Txt(navigationAssets[index]['label']),
  //             child: Container(
  //               width: 60,
  //               margin: padding,
  //               height: 60,
  //               child: Stack(
  //                 fit: StackFit.expand,
  //                 children: <Widget>[
  //                   Container(
  //                     alignment: Alignment(0, -0.5),
  //                     // width: 60,
  //                     // height: 60,
  //                     color: currentPage == index ? ColorsD.main : Colors.white,
  //                     child: Image.asset(
  //                       navigationAssets[index]['asset'],
  //                       color:
  //                           currentPage == index ? Colors.white : ColorsD.main,
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Txt(
  //                       navigationAssets[index]['label'],
  //                       style: TxtStyle()
  //                         ..textColor(currentPage == index
  //                             ? Colors.white
  //                             : ColorsD.main)
  //                         ..fontSize(1),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget buildActionBtn() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: FloatingActionButton(
          child: Image.asset(
            R.ASSETS_IMAGES_LOGO_PNG,
            color: ColorsD.main,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          onPressed: null),
    );
  }
}
