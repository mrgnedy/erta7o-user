import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/data/models/restaurant_model.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/restaurants_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BuildWorkingHours extends StatelessWidget {
  List<HoursModel> workingHrsList;
  bool isClosed = false;
  @override
  Widget build(BuildContext context) {
    workingHrsList = workingHours(context);
    final HoursModel getTodayWHrs = workingHrsList[DateTime.now().weekday - 1];
    double hrsNow =
        double.tryParse('${TimeOfDay.now().hour}.${TimeOfDay.now().minute}');
        print("HOURS NOW: $hrsNow");
    double todayStartTime = double.tryParse(
        '${getTodayWHrs.startTimeFormatted.hour}.${getTodayWHrs.startTimeFormatted.minute}');
        print("todayStartTime: $todayStartTime");
    double todayEndTime = double.tryParse(
        '${getTodayWHrs.endTimeFormatted.hour}.${getTodayWHrs.endTimeFormatted.minute}');
        print("todayEndTime: $todayEndTime");
    if (todayStartTime > hrsNow || todayEndTime < hrsNow)
      isClosed = true;
    else
      isClosed = false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.timer,
              color: isClosed ? Colors.red : Colors.green,
            ),
            Txt(isClosed ? LocaleKeys.closed : LocaleKeys.open)
          ],
        ),
        InkWell(
          onTap: () => showTimes(context),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Txt(
                      '${getTodayWHrs.startTimeFormatted.format(context)} - ${getTodayWHrs.endTimeFormatted.format(context)}')),
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
  List<HoursModel> workingHours(context) => [
        HoursModel(
          day: "${LocaleKeys.monday}",
          startTime: timesList.mondayStartTime,
          endTime: timesList.mondayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.tuesday}",
          startTime: timesList.tuesdayStartTime,
          endTime: timesList.tuesdayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.wednesday}",
          startTime: timesList.wednesdayStartTime,
          endTime: timesList.wednesdayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.thursday}",
          startTime: timesList.thursdayStartTime,
          endTime: timesList.thursdayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.firday}",
          startTime: timesList.fridayStartTime,
          endTime: timesList.fridayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.saturday}",
          startTime: timesList.saturdayStartTime,
          endTime: timesList.saturdayEndTime,
        ),
        HoursModel(
          day: "${LocaleKeys.sunday}",
          startTime: timesList.sundayStartTime,
          endTime: timesList.sundayEndTime,
        ),
      ];
  showTimes(context) async {
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
                workingHrsList.length,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Txt('${workingHrsList[index].day}', style: style),
                    Txt('${workingHrsList[index].startTimeFormatted.format(context)} -- ${workingHrsList[index].endTimeFormatted.format(context)}',
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

class HoursModel {
  String day;
  String startTime;
  String endTime;
  HoursModel({this.day, this.startTime, this.endTime});

  TimeOfDay get startTimeFormatted => convertTo12Mode(startTime);
  TimeOfDay get endTimeFormatted => convertTo12Mode(endTime);

  TimeOfDay convertTo12Mode(String time) {
    return TimeOfDay(
        hour: int.tryParse(time.split(':')[0]),
        minute: int.tryParse(time.split(':')[1]));
  }
}
