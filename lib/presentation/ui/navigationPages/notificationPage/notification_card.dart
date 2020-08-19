import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final style = TxtStyle()..textColor(Colors.black)..textOverflow(TextOverflow.ellipsis)..maxLines(2);
  final styleSec = TxtStyle()..textColor(Colors.grey[800]);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(bottom:8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(R.ASSETS_IMAGES_STAR_PNG),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Txt('هذا التنبيه هو خاص بتنبيه العميل كى ينتبه ان لديه اشعار كي يبتم تنبتنبيه العميل كى ينتبه ان لديه اشعار كي يبتم تنبيهه', style: style),
                Txt('24 ساعة', style: styleSec,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
