// import 'package:auto_route/auto_route.dart';
// import 'package:division/division.dart';
// import 'package:request_mandoub/core/utils.dart';
// import 'package:request_mandoub/presentation/state/auth_store.dart';
// import 'package:request_mandoub/presentation/widgets/tet_field_with_title.dart';
// import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';

// class RechangePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: BuildAuthAppBar(
//           height: RM.mediaQuery.size.height / 4,
//           title: "نسيت كلمة المرور",
//         ),
//         body: _BuildBody(),
//       ),
//     );
//   }
// }

// class _BuildBody extends StatelessWidget {
//   pwOnChange(s) => RM.get<AuthStore>().state.authModel.data.password = s;
//   confirmPwOnChange(s) =>
//       RM.get<AuthStore>().state.authModel.data.confirmPassword = s;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         heightFactor: 2,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TetFieldWithTitle(
//               title: "كلمة المرور الجديدة",
//               onChanging: pwOnChange,
//             ),
//             TetFieldWithTitle(
//                 title: "إعادة كلمة المرور الجديدة",
//                 onChanging: confirmPwOnChange),
//             SizedBox(
//               height: RM.mediaQuery.size.height * 0.03,
//             ),
//             _ConfirmBtn()
//           ],
//         ));
//   }
// }

// class _ConfirmBtn extends StatelessWidget {
//   RMKey<AuthStore> _rmKey = RMKey();
//   final rm = RM.get<AuthStore>();
//   onData(c, d) => ExtendedNavigator.rootNavigator.pushNamed(Routes.mainPage);
//   onError(c, e) {
//     print("RECHANGE PW $e");
//     AlertDialogs.failed(context: c, content: "من فضلك أعد المحاولة");
//   }

//   rechangePW() {
//     if (_rmKey.state.authModel.data.password == null ||
//         _rmKey.state.authModel.data.password.length < 6)
//       AlertDialogs.failed(context: RM.context, content: "كلمة المرور قصيرة");
//     else if (_rmKey.state.authModel.data.password !=
//         _rmKey.state.authModel.data.confirmPassword)
//       AlertDialogs.failed(
//           context: RM.context, content: "كلمة المرور غير مطابقة");
//     else
//       _rmKey.setState((state) => state.rechangePW(),
//           onData: onData, onError: onError);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WhenRebuilder(
//       rmKey: _rmKey,
//       observe: () => rm,
//       onIdle: () => _ConfirmOnData(callback: rechangePW),
//       onWaiting: () => WaitingWidget(),
//       onError: (e) => _ConfirmOnData(hasError: true, callback: rechangePW),
//       onData: (d) => _ConfirmOnData(callback: rechangePW),
//     );
//   }
// }

// class _ConfirmOnData extends StatelessWidget {
//   final bool hasError;
//   final Function callback;
//   _ConfirmOnData({Key key, this.hasError = false, this.callback})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final style = TxtStyle()
//       ..background.color(hasError ? Colors.red : Colors.amber)
//       ..height(RM.mediaQuery.size.height / 16)
//       ..width(RM.mediaQuery.size.width * 0.5)
//       ..textColor(Colors.white)
//       ..alignmentContent.center()
//       ..borderRadius(all: 12)
//       ..fontWeight(FontWeight.bold)
//       ..fontSize(18);
//     final gesture = Gestures()..onTap(callback);
//     return Txt(
//       'تأكيد',
//       style: style,
//       gesture: gesture,
//     );
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/const/resource.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/auth_store.dart';
import 'package:request_mandoub/presentation/ui/authPages/subWidgets/text_fields.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../router.gr.dart';

class RechangePWPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  final changePWStyle = TxtStyle()
    ..fontSize(24)
    ..textColor(Colors.white)
    ..fontWeight(FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(R.ASSETS_IMAGES_LOGO_PNG, color: Colors.white),
            SizedBox(width: size.height * 0.035),
            Txt(LocaleKeys.changePassword, style: changePWStyle),
            BuildTextFormField(
                label: LocaleKeys.newPassowrd, onChanged: getPassword),
            BuildTextFormField(
                label: LocaleKeys.confrimNewPassword,
                onChanged: getConfirmPassword),
            SizedBox(height: size.height * 0.025),
            _EnterBtn(),
          ],
        ),
      ),
    );
  }

  getPassword(String s) {
    IN.get<AuthStore>().authModel.data.password = s;
  }

  getConfirmPassword(String s) {
    IN.get<AuthStore>().authModel.data.confirmPass = s;
  }
}

class _EnterBtn extends StatelessWidget {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WhenRebuilderOr(
      builder: (context, model) => _editBtn(),
      onWaiting: () => WaitingWidget(),
      observe: () => RM.get<AuthStore>(),
    );
  }

  Widget _editBtn() {
    final style = TxtStyle()
      ..width(size.width * 0.4)
      ..height(size.height / 16)
      ..background.color(Colors.white)
      ..alignmentContent.center()
      ..textColor(ColorsD.main)
      ..borderRadius(all: 5);
    final gesture = Gestures()
      ..onTap(() {
        if (IN.get<AuthStore>().authModel.data.password !=
            IN.get<AuthStore>().authModel.data.confirmPass)
          RM.show((c) => AlertDialogs.failed(
              context: c, content: LocaleKeys.unidenticalPassword));
        else
          RM.get<AuthStore>().setState(
                (s) => s.rechangePassowrd(),
                onError: (context, error) => print(error),
                onData: (context, model) => ExtendedNavigator.rootNavigator
                    .pushNamedAndRemoveUntil(
                        Routes.splashScreen, (route) => false),
              );
      });
    return Txt(LocaleKeys.signin, style: style, gesture: gesture);
  }
}
