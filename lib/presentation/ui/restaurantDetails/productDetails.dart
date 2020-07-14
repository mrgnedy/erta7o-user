import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/widgets/tet_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../router.gr.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    // context.locale = Locale('ar');
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      // height: size.height * 0.8,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildProductImage(),
            buildProductName(),
            buildProductPrice(),
            buildProductConfig(),
            buildAdditions(),
            buildActions(),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage() {
    return Container(
      height: size.height / 4,
      width: size.width * 0.6,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              ))),
    );
  }

  Widget buildProductName() {
    return Txt(
      'Very Burger',
      style: TxtStyle()
        ..alignment.center()
        ..alignmentContent.center()
        ..textColor(Colors.white),
    );
  }

  Widget buildProductPrice() {
    return Txt(
      '${LocaleKeys.price}: 55 ${LocaleKeys.currency}',
      style: TxtStyle()
        ..alignment.center()
        ..alignmentContent.center()
        ..textColor(Colors.white),
    );
  }

  List<String> sandwitchTypes = [
    "صغير",
    "وسط",
    "كبير",
    "كومبو",
  ];

  int selectedType = 0;

  Widget buildProductConfig() {
    return Container(
      width: size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(LocaleKeys.sandwitchType),
              ...List.generate(sandwitchTypes.length, (index) {
                return Container(
                  height: size.height / 20,
                  width: size.width * 0.4,
                  child: RadioListTile(
                      value: index,
                      title: Txt(sandwitchTypes[index]),
                      activeColor: Colors.white,
                      groupValue: selectedType,
                      onChanged: (i) => setState(() => selectedType = i)),
                );
              }) //erfa kamon 7elba ganzbel lemon x2
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Txt(LocaleKeys.qty), buildCounter()],
          ),
        ],
      ),
    );
  }

  Widget buildAddition() {
    return TetFieldWithTitle(
      title: LocaleKeys.addMoreOrders,
      // dir
    );
  }

  Widget buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildCustomBtn(LocaleKeys.addMoreOrders, () {}),
        buildCustomBtn(LocaleKeys.completeOrder, showTimeDialog),
      ],
    );
  }

  Widget buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Txt(LocaleKeys.orderDetails),
    );
  }

  Widget buildCustomBtn(String label, Function onTap) {
    final size = MediaQuery.of(context).size;
    final style = TxtStyle()
      ..textColor(ColorsD.main)
      ..fontSize(18)
      ..fontFamily('bein')
      ..borderRadius(all: 5)
      ..width(size.width * 0.38)
      ..height(size.height / 16)
      ..alignmentContent.center()
      ..alignment.center()
      ..margin(horizontal: 5)
      ..background.color(Colors.white);
    final gesture = Gestures()..onTap(onTap);
    return Txt(
      label,
      style: style,
      gesture: gesture,
    );
  }

  int count = 1;
  Widget buildCounter() {
    final style = ParentStyle()
      ..border(all: 1, color: Colors.white)
      ..borderRadius(all: 8)
      ..padding(all: 0)
      ..width(size.width * 0.35)
      ..height(size.height / 16);
    Function addOnTap = () => setState(() => count++);
    Function removeOnTap = count <= 1 ? null : () => setState(() => count--);
    // Timer timer;
    // Function addOnLongTap = () =>
    //   timer = Timer.periodic(Duration(milliseconds: 100), addOnTap);

    // Function addOnRelease = ()=>timer.cancel();
    // Function removeOnLongTap =
    //     count <= 1 ? null : () => timer = Timer.periodic(Duration(milliseconds: 100), removeOnTap);

    return Parent(
      style: style,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              onPressed: removeOnTap,
              icon: Icon(Icons.remove),
              color: Colors.white),
          Txt("$count"),
          IconButton(
            onPressed: addOnTap,
            alignment: Alignment.center,
            icon: Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget buildAdditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Txt(
            LocaleKeys.additions,
            style: TxtStyle()
              ..fontSize(18)
              ..textColor(Colors.white),
          ),
          Container(
            height: size.height / 14,
            width: size.width * 0.8,
            child: TextFormField(
              cursorColor: Colors.white,
              cursorRadius: Radius.circular(10),
              style: TextStyle(height: 1.5),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showTimeDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: size.height/4,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Txt(LocaleKeys.chooseTime, style: TxtStyle()..textColor(ColorsD.main),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTime(),
                ),
                buildDialogActons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  int hrsCount = 1;
  Widget buildTime() {
    final style = ParentStyle()
      ..border(all: 1, color: ColorsD.main)
      ..borderRadius(all: 8)
      ..padding(all: 0)
      ..width(size.width * 0.45)
      ..height(size.height / 16);
    return StatefulBuilder(
      builder: (context, setState) {
    Function addOnTap = () => setState(() => hrsCount++);
    Function removeOnTap = count <= 1 ? null : () => setState(() => hrsCount--);
        return Parent(
          style: style,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: removeOnTap,
                  icon: Icon(Icons.remove),
                  color: ColorsD.main),
              Txt("$hrsCount ساعة",style:TxtStyle()..textColor(ColorsD.main)),
              IconButton(
                onPressed: addOnTap,
                alignment: Alignment.center,
                icon: Icon(Icons.add),
                color: ColorsD.main,
              )
            ],
          ),
        );
      }
    );
  }

  Widget buildDialogActons() {
    final doneStyle = TxtStyle()
      ..width(size.width * 0.2)
      ..height(size.height / 18)
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..background.color(ColorsD.main)
      ..textColor(Colors.white);
    final backStyle = TxtStyle()
      ..width(size.width * 0.2)
      ..height(size.height / 18)
      ..borderRadius(all: 5)
      ..alignmentContent.center()
      ..background.color(Colors.white)
      ..textColor(ColorsD.main)
      ..border(all: 1, color: ColorsD.main);
    final doneGesture = Gestures()
      ..onTap(() => {
            ExtendedNavigator.rootNavigator.pop(),
            ExtendedNavigator.rootNavigator.pushNamed(Routes.mapScreen, arguments: MapScreenArguments(setLocation: null))
          });
    final backGesture = Gestures()
      ..onTap(() => ExtendedNavigator.rootNavigator.pop());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Txt(
          LocaleKeys.back,
          style: backStyle,
          gesture: backGesture,
        ),
        SizedBox(width: 10),
        Txt(LocaleKeys.done, style: doneStyle, gesture: doneGesture),
      ],
    );
  }
}
