import 'package:division/division.dart';
import 'package:erta7o/generated/locale_keys.g.dart';
import 'package:erta7o/presentation/state/setting_store.dart';
import 'package:erta7o/presentation/widgets/waiting_widget.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'notification_card.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilderOr<SettingStore>(
      initState: (c, rm) => rm.setState(
        (s) => s.getNotifications(),
      ),
      observe: () => RM.get<SettingStore>(),
      builder: (context, model) => _NotificationPage(),
      onWaiting: () => IN.get<SettingStore>().notificationModel == null
          ? WaitingWidget()
          : _NotificationPage(),
    );
  }
}

class _NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IN.get<SettingStore>().notificationModel.data.isEmpty
        ? Center(child: Txt(LocaleKeys.noNotification))
        : SingleChildScrollView(
            child: Center(
              child: Column(
                children: List.generate(
                  IN.get<SettingStore>().notificationModel.data.length,
                  (index) => NotificationCard(
                    index: index,
                  ),
                ),
              ),
            ),
          );
  }
}
