import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../router.gr.dart';

class RestaurantDetails extends StatelessWidget {
  final RestaurantData restaurantData;

  RestaurantDetails({Key key, this.restaurantData}) : super(key: key);
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // context.locale = Locale('ar');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: ListTile(
            title: Txt(restaurantData.name),
            subtitle: Txt(restaurantData.slogan),
            leading: Container(
              width: size.height / 12,
              height: size.height / 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                  image: DecorationImage(
                      image: NetworkImage(restaurantData.logo),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      child: Container(
        width: size.width * 0.8,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                    height: size.height / 4,
                    child: Image.network(restaurantData.logo)),
                Txt(restaurantData.details),
                rateWidget(),
                Divider(thickness: 1, color: Colors.white)
                    .withWidth(width: size.width * 0.5),
                workingHours(),
                Divider(thickness: 1, color: Colors.white)
                    .withWidth(width: size.width * 0.5),
                menuWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Txt(LocaleKeys.userReviews),
          ],
        ),
        restaurantData.rate.contains('null')
            ? Txt(LocaleKeys.noReviews)
            : Row(
                children: <Widget>[
                  Expanded(
                    child: SmoothStarRating(
                      isReadOnly: true,
                      allowHalfRating: true,
                      starCount: 5,
                      rating: double.parse(restaurantData.rate),
                    ),
                  ),
                  Txt(LocaleKeys.reviews),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              ),
      ],
    );
  }

  Widget workingHours() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.timer,
              color: Colors.green,
            ),
            Txt(LocaleKeys.open)
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(child: Txt('11 - 9')),
            Txt(LocaleKeys.showTime),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        )
      ],
    );
  }

  Widget menuWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () =>
              ExtendedNavigator.rootNavigator.pushNamed(Routes.menuPage),
          child: Row(
            children: <Widget>[
              Txt(LocaleKeys.menu),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.white)
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              dummyImageList.length,
              (index) {
                return Container(
                  height: size.height / 12,
                  width: size.height / 12,
                  margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(dummyImageList[index]),
                        fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class RestaurantData {
  final String name;
  final String slogan;
  final String image;
  final String logo;
  final String details;
  final String availTime;
  final String rate;
  final List<String> menuImages;

  RestaurantData({
    this.name = 'name',
    this.slogan = 'slogan',
    this.image = '{dummyImageList[0]}',
    this.logo = 'sad[sad',
    this.details = 'هذا المطعم يقوم بعمل طعام ',
    this.availTime = '1',
    this.menuImages = dummyImageList,
    this.rate = '4.5',
  });
}

extension on Divider {
  Widget withWidth({width}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: this,
        width: width,
      ),
    );
  }
}
