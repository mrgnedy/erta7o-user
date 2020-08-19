import 'package:easy_localization/easy_localization.dart' as e;
import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/ui/mainPage/mainPage.dart';
import 'package:erta7o/presentation/ui/restaurantDetails/subWidgets.dart/menu_widget.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../router.gr.dart';
import 'subWidgets.dart/working_hours.dart';

import 'package:erta7o/presentation/ui/restaurantDetails/subWidgets.dart/sub_widgets.dart';

class RestaurantDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WhenRebuilderOr<RestaurantsStore>(
      observe: () => RM.get<RestaurantsStore>(),
      initState: (_, m) => m.setState((s) => s.getRestaurant()),
      onWaiting: () => WaitingWidget(),
      builder: (context, model) => _OnData(),
    );
  }
}

class _OnData extends StatelessWidget {
  Restaurants get restaurantData =>
      IN.get<RestaurantsStore>().currentRestaurant.data.restaurant;

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // context.locale = Locale('ar');
    return SafeArea(
      child: Scaffold(
        appBar: RestaurantAppBar(height: size.height / 8),
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
                    child: Image.network(
                        '${APIs.imageBaseUrl}${restaurantData.image}')),
                Txt(restaurantData.desc),
                BuildRateWidget(),
                Divider(thickness: 1, color: Colors.white),
                // .withWidth(width: size.width * 0.5),
                BuildWorkingHours(),
                Divider(thickness: 1, color: Colors.white),
                // .withWidth(width: size.width * 0.5),
                BuildMenus()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// extension on Divider {
//   Widget withWidth({width}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         child: this,
//         width: width,
//       ),
//     );
//   }
// }
