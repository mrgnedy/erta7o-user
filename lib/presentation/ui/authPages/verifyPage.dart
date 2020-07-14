import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class VerifyPage extends StatelessWidget {
  Size size;
  BuildContext ctx;
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
          height: size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                R.ASSETS_IMAGES_LOGO_PNG,
                color: Colors.white,
              ),
              buildText(),
              buildPinCode(),
              buildConfirm(),
              buildResend(),
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

  String code;
  Widget buildPinCode() {
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(bottom: 20),
      child: PinCodeTextField(
        length: 4,
        onChanged: (s) => code = s,
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

  Widget buildConfirm() {
    final style = TxtStyle()
      ..textColor(ColorsD.main)
      ..fontFamily('bein')
      ..fontSize(18)..fontWeight(FontWeight.normal);
    return RaisedButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Txt(
        LocaleKeys.confirm,
        style: style,
      ),
    );
  }

  Widget buildResend() {
    final style = TxtStyle()
      ..border(bottom: 1.5, color: Colors.white)
      ..textColor(Colors.white)
      ..bold(false)
      ..fontSize(16)..margin(top:20);
    final Function onTap = () => Toast.show('wharever', ctx);
    return Txt(
      LocaleKeys.resendCode,
      style: style,
      gesture: Gestures()..onTap(onTap),
    );
  }
}
