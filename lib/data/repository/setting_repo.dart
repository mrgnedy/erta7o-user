import 'package:erta7o/core/api_utils.dart';

class SettingRepo {
  Future getSettings()async{
    String url = APIs.settinginfoEP;
    return await APIs.getRequest(url);
  }
  Future getNotification()async{
    String url = APIs.usernotificationsEP;
    return await APIs.getRequest(url);
  }
  Future delNotification(notificationID)async{
    String url = APIs.delnotificationEP;
    Map<String, dynamic> body = {
      'notification_id' : '$notificationID'
    };
    return await APIs.postRequest(url, body);
  }
  Future contactUs(Map<String, dynamic> body)async{
    String url = APIs.contactUsEP;
    return await APIs.postRequest(url, body);
  }
  Future getProfile(Map<String, dynamic> body)async{
    String url = APIs.contactUsEP;
    return await APIs.postRequest(url, body);
  }
}