import 'package:division/division.dart';
import 'package:erta7o/const/resource.dart';
import 'package:erta7o/core/utils.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/services.dart';
import 'package:switches_kit/Example/ThemeExample.dart';
import 'package:switches_kit/switches_kit.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BuildProfilePicture(),
              
              Divider(),
              BuildSwitchNotification(),
              BuildNumberOfOrders(),
              BuildPhoneNumber(),
              BuildPassword(),
              Divider(),
              BuildToggleLang(),
              Divider(),
              BuildSignAsDelivery()
            ],
          ),
        ),
      ),
    );
  }
}

class BuildProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: size.height / 10,
          width: size.height / 11,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                height: size.height / 11,
                width: size.height / 11,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(R.ASSETS_IMAGES_CHECK_PNG),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(isAr(context) ? -0.8 : 0.8, 1.1),
                child: Icon(Icons.camera_enhance, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width / 70,
        ),
        Txt('اسم المستخدم')
      ],
    );
  }
}

class BuildSwitchNotification extends StatelessWidget {
  bool notifToggle = true;
  @override
  Widget build(BuildContext context) {
    // context.locale = Locale('ar');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.notification),
        StatefulBuilder(builder: (context, setState) {
          return Switch.adaptive(
            value: notifToggle,
            onChanged: (s) {
              setState(() => notifToggle = s);
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            activeTrackColor: Colors.white,
          );
        })
      ],
    );
  }
}

class BuildNumberOfOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.orderNumber),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Txt("5 ${LocaleKeys.order}"),
        )
      ],
    );
  }
}

class BuildPhoneNumber extends StatelessWidget {
  bool isEdit = false;
  TextEditingController phoneCtrler = TextEditingController(text: "123456789");
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.phone),
        StatefulBuilder(builder: (context, setState) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: size.width * 0.3,
                height: size.height / 16,
                child: TextFormField(
                  controller: phoneCtrler,
                  enabled: isEdit,
                  textAlign: TextAlign.center,
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder()),
                ),
              ),
              IconButton(
                color: Colors.grey,
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() => isEdit = !isEdit);
                },
              )
            ],
          );
        })
      ],
    );
  }
}

class BuildPassword extends StatelessWidget {
  bool isEdit = false;
  TextEditingController phoneCtrler = TextEditingController(text: "123456789");
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.password),
        StatefulBuilder(builder: (context, setState) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: size.width * 0.3,
                height: size.height / 16,
                child: TextFormField(
                  controller: phoneCtrler,
                  enabled: isEdit,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder()),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.grey,
                onPressed: () {
                  setState(() => isEdit = !isEdit);
                },
              )
            ],
          );
        })
      ],
    );
  }
}

class BuildToggleLang extends StatelessWidget {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.language),
        Container(
          width: size.width * 0.32,
          height: size.height / 19,
          child: LabeledToggle(
            thumbSize: size.height/20,
            onText: "العربية",
            offText: 'English',
            value: isAr(context),
            onTextColor: Colors.white,
            onChanged: (s) =>
                (context.locale = Locale(isAr(context) ? "en" : "ar")),
            onBorderColor: Colors.white,
            forceWidth: false,
            borderSize: 2,
            onBkColor: ColorsD.main,
            onThumbColor: Colors.white,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutCubic,
            transitionType: TextTransitionTypes.FADE,
            rotationAnimation: false,
            offBorderColor: Colors.white,
            offThumbColor: Colors.white,
            offTextColor: Colors.white,
            // thum
          ),
        ),
      ],
    );
  }
}
class BuildSignAsDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(LocaleKeys.loginAsMandob)
      ],
    );
  }
}