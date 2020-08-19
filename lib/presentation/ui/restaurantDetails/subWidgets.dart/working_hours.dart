import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/restaurant_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildWorkingHours extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        InkWell(
          onTap: () => showTimes(context),
          child: Row(
            children: <Widget>[
              Expanded(child: Txt('11 - 9')),
              Txt(LocaleKeys.showTime),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }

  Times get timesList =>
      IN.get<RestaurantsStore>().currentRestaurant.data.times.first;
  wharever() {}

  showTimes(context) async {
    List workingHours = [
      {
        "day": "${LocaleKeys.monday}",
        "startTime": "${timesList.mondayStartTime}",
        "endTime": "${timesList.mondayStartTime}",
      },
      {
        "day": "${LocaleKeys.tuesday}",
        "startTime": "${timesList.tuesdayStartTime}",
        "endTime": "${timesList.tuesdayEndTime}",
      },
      {
        "day": "${LocaleKeys.wednesday}",
        "startTime": "${timesList.wednesdayStartTime}",
        "endTime": "${timesList.wednesdayEndTime}",
      },
      {
        "day": "${LocaleKeys.thursday}",
        "startTime": "${timesList.thursdayStartTime}",
        "endTime": "${timesList.thursdayEndTime}",
      },
      {
        "day": "${LocaleKeys.firday}",
        "startTime": "${timesList.fridayStartTime}",
        "endTime": "${timesList.fridayEndTime}",
      },
      {
        "day": "${LocaleKeys.saturday}",
        "startTime": "${timesList.saturdayStartTime}",
        "endTime": "${timesList.saturdayEndTime}",
      },
      {
        "day": "${LocaleKeys.sunday}",
        "startTime": "${timesList.sundayStartTime}",
        "endTime": "${timesList.sundayEndTime}",
      },
    ];
    final size = MediaQuery.of(context).size;
    final style = TxtStyle()..textColor(Colors.black);
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                workingHours.length,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Txt('${workingHours[index]['day']}', style: style),
                    Txt('${workingHours[index]['startTime']} -- ${workingHours[index]['endTime']}',
                        style: style),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
