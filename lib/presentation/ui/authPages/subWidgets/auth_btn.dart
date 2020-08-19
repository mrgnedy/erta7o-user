import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../router.gr.dart';

class BuildAuthAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr(
      rmKey: IN.get<AuthStore>().registerKey,
      observe: () => RM.get<AuthStore>(),
      builder: (context, model) => _OnData(),
      onWaiting: () => WaitingWidget(color: Colors.white),
    );
  }
}

class _OnData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildAuthAction();
  }

  // final navigateToForget = Gestures()..onTap(() =>ExtendedNavigator.rootNavigator.pushNamed(Routes.forget));
  bool get isCreate => IN.get<AuthStore>().authMode == AuthMode.register;
  Widget buildAuthAction() {
    return Column(
      children: [
        isCreate ? buildRegister() : buildLogin(),
        Txt(LocaleKeys.forgotPassowrd),
        StylesD.richText(
          mainText: isCreate ? LocaleKeys.haveAccount : LocaleKeys.noAccount,
          subText: isCreate ? LocaleKeys.loginNow : LocaleKeys.registerNow,
          onTap: () => RM.get<AuthStore>().setState(
              (s) => s.authMode = AuthMode.values[1 - s.authMode.index]),
        )
      ],
    );
  }

  final style = TxtStyle()
    ..textColor(ColorsD.main)
    ..fontFamily('bein')
    ..fontSize(18)
    ..fontWeight(FontWeight.normal);

  onRegisterData(c, d) =>
      ExtendedNavigator.rootNavigator.pushNamed(Routes.verifyPage);
  onLoginData(c, d) =>
      ExtendedNavigator.rootNavigator.pushNamed(Routes.mainUserPage);

  onLogInError(c, e) {
    if (e.toString().contains('activ'))
      ExtendedNavigator.rootNavigator.pushNamed(Routes.verifyPage);
    else
      AlertDialogs.failed(context: c, content: e.toString());
  }

  onRegError(c, e) {
    AlertDialogs.failed(context: c, content: e.toString());
  }

  Widget buildRegister() {
    return RaisedButton(
      child: Txt(
        LocaleKeys.register,
        style: style,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        // if (!IN.get<AuthStore>().authFormKey.currentState.validate()) return;
        IN.get<AuthStore>().registerKey.setState((s) => s.register(),
            onData: onRegisterData, onError: onRegError);
      },
    );
  }

  Widget buildLogin() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Txt(
            LocaleKeys.signin,
            style: style,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            // if (!IN.get<AuthStore>().authFormKey.currentState.validate())
            //   return;
            IN.get<AuthStore>().registerKey.setState((s) => s.login(),
                onData: onLoginData, onError: onLogInError);
          },
        ),
      ],
    );
  }
}
