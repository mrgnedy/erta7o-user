import 'package:division/division.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/presentation/state/setting_store.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AboutPage extends StatelessWidget {
  final String title;
  final String label;

  const AboutPage({Key key, this.title, this.label}) : super(key: key);
  String get settingInfo =>
      IN.get<SettingStore>().settingsModel.data.toJson()[label];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsD.main,
      body: WhenRebuilderOr<SettingStore>(
        observe: ()=>RM.get<SettingStore>(),
        initState: (c,rm ) => rm.state.settingsModel ==null? rm.setState((s) => s.getSettings()): null,
        onWaiting: ()=>WaitingWidget(),
        builder: (context, model) => onData(),
      ),
    );
  }

  Widget onData() {
    return Scaffold(
      backgroundColor: ColorsD.main,
      appBar: AppBar(
        backgroundColor: ColorsD.main,
        elevation: 0,
        centerTitle: true,
        title: Txt(title),
      ),
      body: SingleChildScrollView(
        child: Txt(
          settingInfo,
          style: TxtStyle()
            ..textColor(Colors.white)
            ..textAlign.center()
            ..alignment.topCenter(),
        ),
      ),
    );
  }
}
