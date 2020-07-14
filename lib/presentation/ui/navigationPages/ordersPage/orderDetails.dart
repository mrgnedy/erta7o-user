import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: buildBody(),
    ));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            buildProgress(),
            buildOrderDetails(),
            buildAddressDetails()
          ],
        ),
      ),
    );
  }

  Widget buildProgress() {
    return Container(
      width: size.width * 0.8,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.radio_button_checked, color: ColorsD.main),
          Container(
            width: size.width * 0.3,
            height: 10,
            color: Colors.white,
            child: Container(
                color: ColorsD.main, height: 2, width: size.width * 0.3),
          ),
          Icon(Icons.radio_button_checked, color: ColorsD.main),
          Container(
            width: size.width * 0.3,
            height: 10,
            color: Colors.white,
            child: Container(
                color: Colors.white, height: 5, width: size.width * 0.3),
          ),
          Icon(Icons.radio_button_checked, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildOrderDetails()
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StylesD.richText(
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys',
          width: size.width
        ),
        StylesD.richText(
          mainText: LocaleKeys.sandwitchType,
          subText: 'LocaleKeys',
          width: size.width
        ),
        StylesD.richText(
          mainText: LocaleKeys.additions,
          subText: 'LocaleKeys',
          width: size.width
        ),
        StylesD.richText(
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys',
          width: size.width
        ),
      ],
      ),
    );
  }

  Widget buildAddressDetails(){
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
        StylesD.richText(
          width: size.width,
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys'
        ),
        StylesD.richText(
          width: size.width,
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys'
        ),
        StylesD.richText(
          width: size.width,
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys'
        ),
        StylesD.richText(
          width: size.width,
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys'
        ),
        StylesD.richText(
          width: size.width,
          mainText: LocaleKeys.qty,
          subText: 'LocaleKeys'
        ),
        ],
      ),
    );
  }
}
