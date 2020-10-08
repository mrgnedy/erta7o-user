import 'dart:io';

import 'package:division/division.dart';
import 'package:request_mandoub/const/resource.dart';
import 'package:request_mandoub/core/api_utils.dart';
import 'package:request_mandoub/core/utils.dart';
import 'package:request_mandoub/generated/locale_keys.g.dart';
import 'package:request_mandoub/presentation/state/account_store.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:switches_kit/Example/ThemeExample.dart';
import 'package:request_mandoub/presentation/widgets/waiting_widget.dart';
import 'package:switches_kit/switches_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr<AccountStore>(
      initState: (c, rm) => rm.setState((s) => s.getProfile()),
      observe: () => RM.get<AccountStore>(),
      builder: (context, model) => _ProfilePage(),
    );
  }
}

class _ProfilePage extends StatelessWidget {
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
              // BuildPassword(),
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

class BuildProfilePicture extends StatefulWidget {
  @override
  _BuildProfilePictureState createState() => _BuildProfilePictureState();
}

class _BuildProfilePictureState extends State<BuildProfilePicture> {
  String get image => IN.get<AccountStore>().userProfile?.data?.image;

  String get name => IN.get<AccountStore>().userProfile?.data?.name;

  File selectedImage;

  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
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
                          image: selectedImage != null
                              ? FileImage(selectedImage)
                              : image == null || image.contains('null')
                                  ? AssetImage(R.ASSETS_IMAGES_PROFILE_PNG)
                                  : NetworkImage('${APIs.imageBaseUrl}$image'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: Alignment(isAr(context) ? -0.8 : 0.8, 1.1),
                    child: !isEdit
                        ? Container()
                        : InkWell(
                            onTap: () async {
                              selectedImage =
                                  await StylesD.getProfilePicture(context);
                              setState(() {});
                            },
                            child: Icon(Icons.camera_enhance,
                                color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width / 70,
            ),
            Txt('$name')
          ],
        ),
        isEdit
            ? buildChangePhoto()
            : InkWell(
                onTap: () {
                  setState(() {
                    isEdit = true;
                  });
                },
                child: Icon(Icons.edit, color: Colors.grey)),
      ],
    );
  }

  changePhoto() {
    if (selectedImage == null)
      setState(() => isEdit = false);
    else
      RM.get<AccountStore>().setState(
            (s) => s
                .editProfile(selectedImage.path, null)
                .then((value) => s.getProfile()),
            onData: (context, model) => setState(() => isEdit = false),
          );
  }

  Widget buildChangePhoto() {
    final style = TxtStyle()
      ..textColor(Colors.white)
      ..border(all: 1, color: Colors.white)
      // ..background.color(Colors.white)
      ..padding(all: 4)
      ..margin(all: 4)
      ..borderRadius(all: 5);

    return WhenRebuilderOr<AccountStore>(
      observe: () => RM.get<AccountStore>(),
      builder: (context, model) => Txt(LocaleKeys.confirm,
          style: style, gesture: Gestures()..onTap(changePhoto)),
    );
  }
}

class BuildSwitchNotification extends StatelessWidget {
  // int get notify => IN.get<AccountStore>().userProfile?.data?.notify;
  bool notifToggle =
      IN.get<AccountStore>().userProfile?.data?.notify == 1 ? true : false;
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
              notifToggle = s;
              setState(() {});
              RM.get<AccountStore>().state.editNotify(s ? 1 : 0);
              IN.get<AccountStore>().userProfile.data.notify =
                  notifToggle == true ? 1 : 0;
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
  int get orders => IN.get<AccountStore>().userProfile?.data?.orders;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.orderNumber),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Txt("$orders ${LocaleKeys.order}"),
        )
      ],
    );
  }
}

class BuildPhoneNumber extends StatefulWidget {
  @override
  _BuildPhoneNumberState createState() => _BuildPhoneNumberState();
}

class _BuildPhoneNumberState extends State<BuildPhoneNumber> {
  bool isEdit = false;

  TextEditingController phoneCtrler;

  String get phone => IN.get<AccountStore>().userProfile?.data?.phone ?? '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    phoneCtrler = TextEditingController(text: "$phone");
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
                  inputFormatters: [LengthLimitingTextInputFormatter(13)],
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder()),
                ),
              ),
              isEdit
                  ? changePhone()
                  : IconButton(
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

  Widget changePhone() {
    final style = TxtStyle()
      ..textColor(Colors.white)
      ..border(all: 1, color: Colors.white)
      // ..background.color(Colors.white)
      ..padding(all: 4)
      ..margin(all: 4)
      ..borderRadius(all: 5);

    final gesture = Gestures()
      ..onTap(() {
        RM.get<AccountStore>().setState((s) => s
            .editProfile('', phoneCtrler.text)
            .then((value) => setState(() => isEdit = false))
            .then((value) => s.getProfile()));
      });
    return WhenRebuilderOr<AccountStore>(
      observe: () => RM.get<AccountStore>(),
      builder: (context, model) =>
          Txt('${LocaleKeys.confirm}', style: style, gesture: gesture),
      onWaiting: () => WaitingWidget(),
    );
  }
}

class BuildPassword extends StatefulWidget {
  @override
  _BuildPasswordState createState() => _BuildPasswordState();
}

class _BuildPasswordState extends State<BuildPassword> {
  bool isEdit = false;

  TextEditingController phoneCtrler;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    phoneCtrler = TextEditingController(text: "123456789");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Txt(LocaleKeys.password),
        Row(
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
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            isEdit
                ? changePassword()
                : IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() => isEdit = !isEdit);
                    },
                  )
          ],
        )
      ],
    );
  }

  Widget changePassword() {
    final gesture = Gestures()
      ..onTap(() {
        RM.get<AccountStore>().setState((s) => s
            .editPassword(phoneCtrler.text)
            .then((value) => setState(() => isEdit = false))
            .then((value) => s.getProfile()));
      });
    return WhenRebuilderOr(
      observe: () => RM.get<AccountStore>(),
      builder: (context, model) => Txt(
        "${LocaleKeys.confirm}",
        gesture: gesture,
      ),
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
            thumbSize: size.height / 20,
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
        Txt(
          LocaleKeys.loginAsMandob,
          gesture: Gestures()
            ..onTap(() async {
              String url =
                  "https://play.google.com/store/apps/details?id=com.example.artaahhw";
              if (await canLaunch(url)) {
                await launch(url);
              }
            }),
        ),
      ],
    );
  }
}
