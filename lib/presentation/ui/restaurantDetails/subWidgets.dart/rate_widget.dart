import 'package:division/division.dart';
import 'package:request_mandoub/data/models/user_home_model.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildRateWidget extends StatelessWidget {
  String get rate =>
      IN.get<RestaurantsStore>().currentRestaurant.data.restaurant.rate;
  @override
  Widget build(BuildContext context) {
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
        // rate.contains('null')
        //     ? Txt(LocaleKeys.noReviews)
        //     : 
            Container(
                child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SmoothStarRating(
                          isReadOnly: true,
                          allowHalfRating: true,
                          starCount: 5,
                          rating: double.tryParse(rate)??0,
                        ),
                      ),
                      // Txt(LocaleKeys.reviews),
                      Txt(LocaleKeys.reviews),
                      Icon(Icons.arrow_forward_ios, color: Colors.white)
                    ],
                  
                ),
              ),
      ],
    );
  }
}
