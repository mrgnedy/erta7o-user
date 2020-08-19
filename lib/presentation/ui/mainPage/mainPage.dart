// import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/drawerPages/drawer.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/filters.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/restaurants.dart';
import 'package:erta7o/presentation/ui/mainPage/subWidgets/slider.dart';
import 'package:erta7o/presentation/ui/navigationPages/homePage/home_page.dart';
import 'package:erta7o/presentation/ui/navigationPages/notificationPage/notification_page.dart';
import 'package:erta7o/presentation/ui/navigationPages/ordersPage/all_orders_page.dart/ordersPage.dart';
import 'package:erta7o/presentation/widgets/auction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../navigationPages/homePage/subWidgets/bottom_navigation.dart';
import '../navigationPages/profilePage/profile_page.dart';

class MainUserPage extends StatefulWidget {
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
        currentPage = pageCtrler.page.toInt();
        bottomNavKey.currentState.setState(() {});
      });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    searchAnim = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
      curve: Curves.easeInCubic,
      parent: animationController,
    ));
  }

  PageController pageCtrler;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // context.locale = Locale('ar');
    size = MediaQuery.of(context).size;
    searchBarSize = Size(size.width * 0.5, size.height / 12);
    searchBarAnim = SizeTween(begin: Size(50, 100), end: searchBarSize)
        .animate(CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    ));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerMenu(),
        backgroundColor: ColorsD.main,
        bottomNavigationBar: StatefulBuilder(
            key: bottomNavKey,
            builder: (context, setState) {
              return BottomNavBar(
                  currentPage: currentPage, pageController: pageCtrler);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: buildActionBtn(),
        appBar: buildAppBar(scaffoldKey: _scaffoldKey),
        body: PageView(
          controller: pageCtrler,
          children: [
            HomePage(),
            OrdersPage(),
            NotificationPage(),
            ProfilePage(),
          ],
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
              Text(LocaleKeys.main).tr(),
              animatedSearchWidget(),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(size.height / 12));
  }

  // Widget buildSlider() {
  //   return Container(
  //     height: size.height / 4,
  //     width: size.width,
  //     child: Stack(
  //       fit: StackFit.expand,
  //       children: <Widget>[
  //         CarouselSlider(
  //           // pgCtrler: indicatorCtrler,
  //           items: List.generate(
  //               dummyImageList.length,
  //               (index) => ClipRRect(
  //                     borderRadius: BorderRadius.circular(12),
  //                     child: Image.network(
  //                       dummyImageList[index],
  //                       width: size.width,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   )),
  //           options: CarouselOptions(
  //             enlargeCenterPage: true,
  //             viewportFraction: 1,
  //             aspectRatio: .5,
  //             onScrolled: (p) {
  //               // indicatorCtrler.jumpToPage(2);
  //             },
  //             onPageChanged: (p, reason) {},
  //             height: size.height / 4,
  //             pauseAutoPlayOnManualNavigate: true,
  //             autoPlay: true,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // int selectedFilter = 0;
  // Widget buildFilters() {
  //   List<String> filters = [
  //     LocaleKeys.allOrders,
  //     LocaleKeys.nearOrders,
  //     LocaleKeys.mostOrders
  //   ];
  //   return StatefulBuilder(builder: (context, settState) {
  //     return Container(
  //       width: size.width * 0.8,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: List.generate(filters.length, (index) {
  //           return FittedBox(
  //             child: InkWell(
  //                 onTap: () => settState(() => selectedFilter = index),
  //                 child:
  //                     buildFilterBtn(selectedFilter == index, filters[index])),
  //           );
  //         }),
  //       ),
  //     );
  //   });
  // }

  // Widget buildFilterBtn(bool isSelected, String filter) {
  //   // bool isSelected = selectedIndex == selectedFilter;
  //   final style = TxtStyle()
  //     ..borderRadius(all: 12)
  //     ..padding(vertical: 5, horizontal: 12)
  //     ..fontFamily('bein')
  //     ..fontSize(18)
  //     ..margin(vertical: 15)
  //     ..border(color: Colors.white, all: 2)
  //     ..textColor(isSelected ? ColorsD.main : Colors.white)
  //     ..background.color(isSelected ? Colors.white : ColorsD.main);
  //   return Txt(
  //     filter,
  //     style: style,
  //   );
  // }

  // Widget buildRestaurantsCards() {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: List.generate(
  //       10,
  //       (index) => RestaurantCard(
  //         image: dummyImageList[Random().nextInt(dummyImageList.length)],
  //       ),
  //     ),
  //   );
  // }

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
          child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
          backgroundColor: Colors.white,
          elevation: 0,
          onPressed: null),
    );
  }
}
