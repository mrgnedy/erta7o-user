import 'package:auto_route/auto_route.dart';
import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../../router.gr.dart';

class BuildAuthTFs extends StatelessWidget {
  // RMKey<AuthStore> registerKey = RMKey();
  @override
  Widget build(BuildContext context) {
    // registerKey.state = registerKey.state..register();
    return WhenRebuilderOr(
      // rmKey: RM.get<AuthStore>().state.registerKey,
      observe: () => RM.get<AuthStore>(),
      builder: (context, model) => _OnData(),
      // onWaiting: ()=>WaitingWidget(),
    );
  }
}

class _OnData extends StatelessWidget {
  TextEditingController get locationCtrler =>
      IN.get<AuthStore>().locationCtrler;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          BuildTextFormField(onChanged: getPhone, label: LocaleKeys.phone, isPhone: true,),
          BuildTextFormField(
              onChanged: getName, label: LocaleKeys.userName, changable: true),
          BuildTextFormField(
              isPassword: true,
              onChanged: getPassword,
              label: LocaleKeys.password),
          BuildTextFormField(
            changable: true,
            ctrler: locationCtrler,
            label: LocaleKeys.location,
            icon: InkWell(
              onTap: getLocation,
              child: Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // phoneValidator

  getPhone(String phone) {
    IN.get<AuthStore>().authModel.data.phone = phone;
  }

  getName(String name) {
    IN.get<AuthStore>().authModel.data.name = name;
  }

  getPassword(String password) {
    IN.get<AuthStore>().authModel.data.password = password;
  }

  getLocation() async {
    final postion = (await ExtendedNavigator.rootNavigator
        .pushNamed(Routes.mapScreen) as Position);
    final location = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(postion.latitude, postion.longitude));
    locationCtrler.text = location.first.addressLine;
    IN.get<AuthStore>().authModel.data.address = locationCtrler.text;
    IN.get<AuthStore>().authModel.data.lat = postion.latitude.toString();
    IN.get<AuthStore>().authModel.data.lng = postion.longitude.toString();
  }
}

class BuildTextFormField extends StatefulWidget {
  final TextEditingController ctrler;
  final bool isPhone;
  final String label;
  final Function validator;
  final Widget icon;
  final bool isPassword;
  final Function iconCallback;
  final Function onChanged;
  final int minLines;
  // final bool obsecure;
  final bool changable;

  const BuildTextFormField(
      {Key key,
      this.ctrler,
      this.label,
      this.validator,
      this.icon,
      this.isPhone=false,
      this.minLines,
      this.iconCallback,
      this.changable = false,
      // this.obsecure=false,
      this.isPassword = false,
      this.onChanged})
      : super(key: key);

  @override
  _BuildTextFormFieldState createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  bool obsecure;

  @override
  void initState() {
    // TODO: implement initState
    obsecure = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Visibility(
      visible: widget.changable
          ? IN.get<AuthStore>().authMode == AuthMode.register
          : true,
      child: Container(
        width: size.width * 0.75,
        child: Directionality(
          textDirection: context.locale == Locale('ar')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: TextFormField(
            onChanged: widget.onChanged,
            obscureText: widget.isPassword ? obsecure : false,
            controller: widget.ctrler,
            minLines: widget.minLines,
            maxLines: widget.isPassword ? 1 : null,
            validator: widget.validator,
            style: TextStyle(height: 1.5),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2)),
                    prefix: widget.isPhone? Txt('+966', style: TxtStyle()..textColor(Colors.white),): null,
                suffixIcon: widget.isPassword
                    ? InkWell(
                        child: Icon(Icons.lock, color: Colors.grey),
                        onTap: () {
                          setState(() {
                            obsecure = !obsecure;
                          });
                        },
                      )
                    : widget.icon,
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                labelText: widget.label),
          ),
        ),
      ),
    );
  }
}
