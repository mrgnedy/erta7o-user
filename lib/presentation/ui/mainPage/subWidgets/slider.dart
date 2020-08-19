import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/api_utils.dart';
import 'package:erta7o/data/models/user_home_model.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:erta7o/presentation/widgets/error_widget.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RMKey<RestaurantsStore> sliderKey = RMKey();
    // TODO: implement build
    return WhenRebuilderOr<RestaurantsStore>(
      rmKey: sliderKey,
      observe: () => RM.get<RestaurantsStore>(),
      initState: (c, m) => sliderKey.setState((s) => s.getHome()),
      onWaiting: () =>
          sliderKey.state.userHomeModel == null ? WaitingWidget() : 
          _OnData(),
      onError: (error) => sliderKey.state.userHomeModel == null
          ? OnErrorWidget("Connection Error")
          : _OnData(),
      builder: (context, model) => _OnData(),
    );
  }
}

class _OnData extends StatelessWidget {
  List<Ads> get ads => IN.get<RestaurantsStore>().userHomeModel.data.ads;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RM.get<RestaurantsStore>().isWaiting &&
            IN.get<RestaurantsStore>().userHomeModel == null
        ? WaitingWidget()
        : Container(
            height: size.height / 4,
            width: size.width,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CarouselSlider(
                  // pgCtrler: indicatorCtrler,
                  items: List.generate(
                    ads.length,
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        '${APIs.imageBaseUrl}${ads[index].image}',
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: .5,
                    onScrolled: (p) {
                      // indicatorCtrler.jumpToPage(2);
                    },
                    onPageChanged: (p, reason) {},
                    height: size.height / 4,
                    pauseAutoPlayOnManualNavigate: true,
                    autoPlay: true,
                  ),
                ),
              ],
            ),
          );
  }
}
