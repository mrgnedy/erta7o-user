import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/ui/navigationPages/homePage/subWidgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;
  int currentPage;

  BottomNavBar({Key key, this.pageController, this.currentPage})
      : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> navigationAssets = [
      {'asset': R.ASSETS_IMAGES_STORE_PNG, "label": LocaleKeys.mainNav},
      {'asset': R.ASSETS_IMAGES_DELIVERY_PNG, "label": LocaleKeys.ordersNav},
      {
        'asset': R.ASSETS_IMAGES_NOTIFICATION_PNG,
        "label": LocaleKeys.notificationNav
      },
      {'asset': R.ASSETS_IMAGES_USER_PNG, "label": LocaleKeys.accountNav},
    ];

    // showModalBottomSheet(context: null, builder: null, )
    return BottomAppBar(
      // onTap: (p) => setState(() => widget.currentPage = p),
      key: widget.key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          navigationAssets.length,
          (index) {
            final padding = index == 2
                ? context.locale == Locale('en')
                    ? EdgeInsets.only(left: 20)
                    : EdgeInsets.only(right: 20)
                : index == 1
                    ? context.locale == Locale('en')
                        ? EdgeInsets.only(right: 20)
                        : EdgeInsets.only(left: 20)
                    : EdgeInsets.zero;
            return InkWell(
              onTap: () => setState(() => {
                RM.get<HomeAppBarStore>().setState((s) => s.index=index),
                    widget.currentPage = index,
                    widget.pageController.animateToPage(widget.currentPage,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInCubic)
                  }),
              // title: Txt(navigationAssets[index]['label']),
              child: Container(
                width: 60,
                margin: padding,
                height: 60,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      alignment: Alignment(0, -0.5),
                      // width: 60,
                      // height: 60,
                      color: widget.currentPage == index
                          ? ColorsD.main
                          : Colors.white,
                      child: Image.asset(
                        navigationAssets[index]['asset'],
                        color: widget.currentPage == index
                            ? Colors.white
                            : ColorsD.main,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Txt(
                        navigationAssets[index]['label'],
                        style: TxtStyle()
                          ..textColor(widget.currentPage == index
                              ? Colors.white
                              : ColorsD.main)..fontSize(11)..fontWeight(FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
