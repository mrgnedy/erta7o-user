// import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/widgets/auction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const List<String> dummyImageList = [
  'https://via.placeholder.com/150/0000FF/FFFFFF/?text=Digital.com',
  'https://via.placeholder.com/150/FF0000/808080/?text=Down.com',
  'https://via.placeholder.com/150/FFFF00/000000/?text=WebsiteBuilders.com',
  'https://via.placeholder.com/150/000000/FFFFFF/?text=IPaddress.net',
  'asfdfdsf?ffsdff///null'
];

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    searchAnim = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
      curve: Curves.easeInCubic,
      parent: animationController,
    ));
  }

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
        backgroundColor: ColorsD.main,
        bottomSheet: Container(),
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  int currentPage = 0;
  PageController indicatorCtrler = PageController();
  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildSlider(),
          buildFilters(),
          ...buildRestaurantsCards()
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return PreferredSize(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.main).tr(),
              animatedSearchWidget()
            ],
          ),
        ),
        preferredSize: Size.fromHeight(size.height / 12));
  }

  Widget buildSlider() {
    return Container(
      height: size.height / 4,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CarouselSlider(
            pgCtrler: indicatorCtrler,
            items: List.generate(
                dummyImageList.length,
                (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        dummyImageList[index],
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    )),
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: .5,
              onScrolled: (p) {
                indicatorCtrler.jumpToPage(2);
              },
              onPageChanged: (p, reason) {
              },
              height: size.height / 4,
              pauseAutoPlayOnManualNavigate: true,
              autoPlay: true,
            ),
          ),
          
        ],
      ),
    );
  }

  int selectedFilter = 0;
  List<String> filters = [
    LocaleKeys.allOrders,
    LocaleKeys.nearOrders,
    LocaleKeys.mostOrders
  ];
  Widget buildFilters() {
    return StatefulBuilder(builder: (context, settState) {
      return Container(
        width: size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(filters.length, (index) {
            return InkWell(
                onTap: () => settState(() => selectedFilter = index),
                child: buildFilterBtn(index));
          }),
        ),
      );
    });
  }

  Widget buildFilterBtn(int selectedIndex) {
    bool isSelected = selectedIndex == selectedFilter;
    final style = TxtStyle()
      ..borderRadius(all: 12)
      ..padding(vertical: 5, horizontal: 12)
      ..fontFamily('bein')
      ..fontSize(18)
      ..margin(vertical: 15)
      ..border(color: Colors.white, all: 2)
      ..textColor(isSelected ? ColorsD.main : Colors.white)
      ..background.color(isSelected ? Colors.white : ColorsD.main);
    return Txt(
      filters[selectedIndex],
      style: style,
    );
  }

  List<Widget> buildRestaurantsCards() {
    return List.generate(
      10,
      (index) => RestaurantCard(
        image: dummyImageList[Random().nextInt(dummyImageList.length)],
      ),
    );
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
}
