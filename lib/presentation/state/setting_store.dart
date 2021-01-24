import 'package:erta7o/data/models/contact_us_model.dart';
import 'package:erta7o/data/models/notification_model.dart';
import 'package:erta7o/data/models/settings_model.dart';
import 'package:erta7o/data/repository/setting_repo.dart';

class SettingStore {
  final SettingRepo settingRepo;
  SettingStore(this.settingRepo);

  SettingsModel settingsModel;
  NotificationModel notificationModel;
  ContactUsModel contactUsModel = ContactUsModel();

  Future<SettingsModel> getSettings() async {
    settingsModel = SettingsModel.fromJson(await settingRepo.getSettings());
    return settingsModel;
  }

  Future<NotificationModel> getNotifications() async {
    notificationModel =
        NotificationModel.fromJson(await settingRepo.getNotification());
    return notificationModel;
  }

  Future delNotifications(notificationId) async {
    return await settingRepo.delNotification(notificationId);
  }
  Future contactUs() async {
    final temp= await settingRepo.contactUs(contactUsModel.toJson());
    return temp;
  }
}
