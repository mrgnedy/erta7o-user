// import 'package:erta7o/core/utils.dart';
// import 'package:erta7o/generated/locale_keys.g.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart' as e;

// class BuildSingleOrderDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             StylesD.richText(
//                 mainText: LocaleKeys.qty,
//                 locale: context.locale,
//                 subText: 'LocaleKeys',
//                 width: size.width),
//             StylesD.richText(
//                 mainText: LocaleKeys.sandwitchType,
//                 locale: context.locale,
//                 subText: 'LocaleKeys',
//                 width: size.width),
//             StylesD.richText(
//                 mainText: LocaleKeys.additions,
//                 locale: context.locale,
//                 subText: 'LocaleKeys',
//                 width: size.width),
//             StylesD.richText(
//                 mainText: LocaleKeys.qty,
//                 locale: context.locale,
//                 subText: 'LocaleKeys',
//                 width: size.width),
//           ],
//         ),
//       ),
//     );
//   }
// }