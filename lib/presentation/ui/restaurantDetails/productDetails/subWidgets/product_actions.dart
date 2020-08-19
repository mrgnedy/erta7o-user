// import 'package:division/division.dart';
// import 'package:erta7o/core/utils.dart';
// import 'package:erta7o/generated/locale_keys.g.dart';
// import 'package:flutter/material.dart';

// class BuildProductActions extends StatelessWidget {
//   @override
 

//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         _BuildCustomBtn(label:LocaleKeys.addMoreOrders,onTap: () {}),
//         _BuildCustomBtn(label: LocaleKeys.completeOrder,onTap: () => showTimeDialog(context)),
//       ],
//     );
//   }

  

// }

// class _BuildCustomBtn extends StatelessWidget {
//   final String label;
//   final Function onTap;

//   const _BuildCustomBtn({Key key, this.label, this.onTap}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final style = TxtStyle()
//       ..textColor(ColorsD.main)
//       ..fontSize(18)
//       ..fontFamily('bein')
//       ..borderRadius(all: 5)
//       ..width(size.width * 0.38)
//       ..height(size.height / 16)
//       ..alignmentContent.center()
//       ..alignment.center()
//       ..margin(horizontal: 5)
//       ..background.color(Colors.white);
//     final gesture = Gestures()..onTap(onTap);
//     return Txt(
//       label,
//       style: style,
//       gesture: gesture,
//     );
//   }

  
// }