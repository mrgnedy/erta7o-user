import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:request_mandoub/const/resource.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';

import '../../router.gr.dart';

class VerifyPage extends StatelessWidget {
  final bool isForget;
  Size size;
  BuildContext ctx;

  VerifyPage({Key key, this.isForget = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ctx = context;
    ctx.locale = Locale('en');
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      heightFactor: 2,
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                R.ASSETS_IMAGES_LOGO_PNG,
                // color: Colors.white,
              ),
              buildText(),
              buildPinCode(),
              _BuildVerifyActions()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText() {
    final txtStyle = TxtStyle()
      ..textColor(Colors.white)
      ..fontFamily('bein')
      ..fontSize(20);
    return Txt(
      LocaleKeys.enterCode,
      style: txtStyle,
    );
  }

  onData(c, d) {
    if (isForget)
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(Routes.rechangePWPage, (route) => false);
    else
      ExtendedNavigator.rootNavigator
          .pushNamedAndRemoveUntil(Routes.splashScreen, (route) => false);
  }

  onError(c, e) {
    print(e);
  }

  String code;
  verify(s) {
    RM.get<AuthStore>().setState(
        (s) => isForget ? s.verifyForgetPasowrd() : s.verify(),
        onData: onData,
        onError: onError);
  }

  Widget buildPinCode() {
    return Container(
      width: size.width * 0.55,
      margin: EdgeInsets.only(bottom: 20),
      child: PinCodeTextField(
        length: 4,
        onChanged: (s) => IN.get<AuthStore>().authModel.verifynumber = s,
        onCompleted: verify,
        onSubmitted: verify,
        backgroundColor: Colors.transparent,
        textInputType: TextInputType.number,
        textStyle: TextStyle(color: Colors.white, fontSize: 20),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          inactiveColor: Colors.grey,
          activeColor: Colors.white,
          selectedColor: Colors.white,
        ),
      ),
    );
  }
}

class _BuildVerifyActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WhenRebuilderOr(
      builder: (context, model) => _BuildVerifyOnData(),
      onWaiting: () => WaitingWidget(),
      observe: () => RM.get<AuthStore>(),
    );
  }
}

class _BuildVerifyOnData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _BuildConfirm(),
        _BuildResend(),
      ],
    );
  }
}

class _BuildConfirm extends StatelessWidget {
  onError(c, e) {
    AlertDialogs.failed(context: c, content: LocaleKeys.verifyError);
  }

  onData(c, d) {
    ExtendedNavigator.rootNavigator
        .pushNamedAndRemoveUntil(Routes.splashScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final style = TxtStyle()
      ..textColor(ColorsD.main)
      ..fontFamily('bein')
      ..fontSize(18)
      ..fontWeight(FontWeight.normal);
    return RaisedButton(
      onPressed: () {
        RM
            .get<AuthStore>()
            .setState((s) => s.verify(), onData: onData, onError: onError);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Txt(
        LocaleKeys.confirm,
        style: style,
      ),
    );
  }
}

class _BuildResend extends StatelessWidget {
  onError(c, e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    final style = TxtStyle()
      ..border(bottom: 1.5, color: Colors.white)
      ..textColor(Colors.white)
      ..bold(false)
      ..fontSize(16)
      ..margin(top: 20);
    final Function onTap = () =>
        RM.get<AuthStore>().setState((s) => s.resendVerify(), onError: onError);
    return Txt(
      LocaleKeys.resendCode,
      style: style,
      gesture: Gestures()..onTap(onTap),
    );
  }
}
