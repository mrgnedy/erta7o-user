import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
// import 'package:flutter_localizations/flutter_localizations.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  BuildContext ctx;

  Size size;

  bool isCreate = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // context.locale = Locale('en');
    ctx = context;
    return SafeArea(
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  TextEditingController userCtrler = TextEditingController();

  TextEditingController passwordCtrler = TextEditingController();

  TextEditingController locationCtrler = TextEditingController();

  TextEditingController phoneCtrler = TextEditingController();

  Widget buildBody() {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.8,
            height: isCreate ? size.height * 0.85 : size.height * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                ),
                buildText(),
                Expanded(child: buildAllTextFields()),
                buildAuthAction()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText() {
    final style = TxtStyle()
      ..fontFamily('bein')
      ..fontWeight(FontWeight.normal)
      ..fontSize(24)
      ..textColor(Colors.white);
    return Txt(
      isCreate ? LocaleKeys.register : LocaleKeys.signin,
      style: style,
    );
  }

  Widget buildTextFormField(
      {TextEditingController ctrler,
      String label,
      Function validator,
      Widget icon,
      bool visible = true}) {
    return Visibility(
      visible: visible,
      child: Directionality(
        textDirection:
            ctx.locale == Locale('ar') ? TextDirection.rtl : TextDirection.ltr,
        child: TextFormField(
          controller: ctrler,
          validator: validator,
          style: TextStyle(height: 1.5),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              suffixIcon: icon,
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              labelText: label),
        ),
      ),
    );
  }

  Widget buildAllTextFields() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildTextFormField(ctrler: phoneCtrler, label: LocaleKeys.phone),
          buildTextFormField(
              ctrler: userCtrler,
              label: LocaleKeys.userName,
              visible: isCreate),
          buildTextFormField(
              ctrler: passwordCtrler, label: LocaleKeys.password),
          buildTextFormField(
              visible: isCreate,
              ctrler: userCtrler,
              label: LocaleKeys.location,
              icon: Icon(
                Icons.location_on,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }

  Widget buildAuthAction() {
    return Column(children: [
      isCreate ? buildRegister() : buildLogin(),
      Txt(LocaleKeys.forgotPassowrd),
      StylesD.richText(
          mainText: isCreate ? LocaleKeys.haveAccount : LocaleKeys.noAccount,
          subText: isCreate ? LocaleKeys.loginNow : LocaleKeys.registerNow,
          onTap: () => setState(() => isCreate = !isCreate))
    ]);
  }

  final style = TxtStyle()
    ..textColor(ColorsD.main)
    ..fontFamily('bein')
    ..fontSize(18)
    ..fontWeight(FontWeight.normal);

  Widget buildRegister() {
    return RaisedButton(
      child: Txt(
        isCreate ? LocaleKeys.register : LocaleKeys.signin,
        style: style,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        ctx.locale = ctx.locale == Locale('ar') ? Locale('en') : Locale('ar');
        isCreate = !isCreate;
        setState(() {});
      },
    );
  }

  Widget buildLogin() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Txt(
            LocaleKeys.register,
            style: style,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            ctx.locale =
                ctx.locale == Locale('ar') ? Locale('en') : Locale('ar');
            isCreate = !isCreate;
            setState(() {});
          },
        ),
      ],
    );
  }
}
