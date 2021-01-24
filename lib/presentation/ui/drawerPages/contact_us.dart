import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/data/models/contact_us_model.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/state/setting_store.dart';
import 'package:erta7o/presentation/ui/authPages/subWidgets/text_fields.dart';
import 'package:erta7o/presentation/widgets/tet_field_with_title.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsD.main,
        appBar: AppBar(
          centerTitle: true,
          title: Txt(LocaleKeys.contactUs),
        ),
        body: _BuildBody(),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  onChangingName(String s) {
    RM.get<SettingStore>().state.contactUsModel.name = s;
  }
  onChangingPhone(String s) {
    RM.get<SettingStore>().state.contactUsModel.phone = s;
  }

  onChangingMsg(String s) {
    RM.get<SettingStore>().state.contactUsModel.message = s;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
          heightFactor: 1,
          child: Column(
      children: <Widget>[
          BuildTextFormField(
            label: LocaleKeys.name,
            onChanged: onChangingName,
          ),
          BuildTextFormField(
            label: LocaleKeys.phone,
            onChanged: onChangingPhone,
          ),
          BuildTextFormField(
            label: LocaleKeys.leaveMsg,
            onChanged: onChangingMsg,
            minLines: 6,
          ),
          SizedBox(height: RM.mediaQuery.size.height*0.03),
          _BuildSendMsg()
      ],
    ),
        ));
  }
}

class _BuildSendMsg extends StatelessWidget {
  RMKey<SettingStore> _rmKey = RMKey();
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder<SettingStore>(
      rmKey: _rmKey,
      observe: () => RM.get<SettingStore>(),
      onIdle: () => _BuildSendMsgOnData(),
      onWaiting: () => WaitingWidget(),
      onError: (e) => _BuildSendMsgOnData(),
      onData: (d) => _BuildSendMsgOnData(),
    );
  }
}

class _BuildSendMsgOnData extends StatelessWidget {
  ContactUsModel get sendMsgModel => RM.get<SettingStore>().state.contactUsModel;
  onError(c, e) {
    if (sendMsgModel.name == null || sendMsgModel.name.isEmpty)
      AlertDialogs.failed(content: 'من فضلك أدخل اسمك', context: c);
    else if (sendMsgModel.message == null || sendMsgModel.message.isEmpty)
      AlertDialogs.failed(content: 'من فضلك أدخل نص رسالتك',context: c);
    else {
      print(e);
      AlertDialogs.failed(content: 'تعذر ارسال رسالتك, من فضلك أعد المحاولة',context: c);
    }
  }

  onData(c, d) {
    ExtendedNavigator.rootNavigator.pop();
  }

  final style = TxtStyle()
    ..borderRadius(all: 5)
    ..alignmentContent.center()
    ..fontSize(18)
    ..background.color(Colors.white)
    ..textColor(ColorsD.main)
    ..width(RM.mediaQuery.size.width * 0.5)
    ..height(RM.mediaQuery.size.height / 16);
  @override
  Widget build(BuildContext context) {
    final gesture = Gestures()
      ..onTap(() {
        RM
            .get<SettingStore>()
            .setState((s) => s.contactUs(), onData: onData, onError: onError);
      });
    return Txt(LocaleKeys.send, style: style, gesture: gesture);
  }
}
