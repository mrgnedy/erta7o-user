import 'package:erta7o/core/utils.dart';
import 'package:erta7o/presentation/state/order_store.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:steps_indicator/steps_indicator.dart';

class BuildProgress extends StatelessWidget {
  List statusList = [
    "فى انتظار العروض",
    "تم اختيار المندوب",
    "قيد التنفيذ",
    "فى الطريق اليك",
    "تم التسليم",
  ];

  int get status => null;//int.tryParse(IN.get<OrderStore>().currentOrder?.data?.first?.order?.status);
  int get selectedStep =>
      status != null ? status + 1 : !IN.get<OrderStore>().isConfirmed ? 0 : 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // IN.get<OrderStore>().currentOrder.status ='';
    print('$status is ');
    return Visibility(
        // color: Colors.amber,
        // visible: IN.get<OrderStore>().isConfirmed,
        child: Column(
          children: <Widget>[
            Container(
              // width: size.width * 0.9,
              child: Directionality(
                textDirection: context.locale == Locale('ar')
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: StepsIndicator(
                  nbSteps: 5,
                  selectedStep: selectedStep,
                  doneLineColor: Colors.white,
                  doneStepColor: Colors.white,
                  isHorizontal: true,
                  lineThickness: 2,
                  selectedStepColorIn: ColorsD.main,
                  selectedStepColorOut: Colors.white,
                  selectedStepBorderSize: 7,
                  // unselectedStepColor: Colors.white,
                  lineLength:
                      isPortrait(context) ? size.width / 8 : size.width / 6.2,
                  selectedStepSize: 30,
                  doneStepSize: 30,
                  unselectedStepSize: 30,
                  undoneLineColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  statusList.length,
                  (index) => Container(
                    width: size.width / 5,
                    child: Text(statusList[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.5,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
