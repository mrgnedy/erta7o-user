import 'package:division/division.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/ui/authPages/subWidgets/auth_btn.dart';
import 'package:erta7o/presentation/ui/authPages/subWidgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:states_rebuilder/states_rebuilder.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  BuildContext ctx;

  Size size;

  bool get isCreate => IN.get<AuthStore>().authMode == AuthMode.register;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // context.locale = Locale('en');
    ctx = context;
    return SafeArea(
      child: Scaffold(
        body: WhenRebuilderOr(
          builder: (context, model) => buildBody(),
          observe: () => RM.get<AuthStore>(),
        ),
      ),
    );
  }
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
                Expanded(child: BuildAuthTFs()),
                BuildAuthAction()
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
}
