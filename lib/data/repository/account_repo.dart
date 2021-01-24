import 'package:erta7o/core/api_utils.dart';

class AccountRepo {
  Future editNotify(int shouldNotify) async {
    String url = APIs.updatenotifyEP;
    Map<String, dynamic> body = {"notify": "$shouldNotify"};
    return await APIs.postRequest(url, body);
  }

  Future editUserImage(String image, String phone) async {
    String url = APIs.edituserprofileEP;
    Map<String, String> body = {"phone": '${phone?? ''}'};
    if (phone == null)
      return await APIs.postWithFile(url, {},
          filePath: image, fileName: 'personalimage');
    else
      return await APIs.postRequest(url, body);
  }

  Future uesrProfile(userID) async {
    String url = APIs.profileEP;
    Map<String, String> body = {"user_id": '$userID'};
    return await APIs.postRequest(url, body);
  }

  Future editPass(password) async {
    String url = APIs.editpassEP;
    Map<String, dynamic> body = {
      "old_password": "$password",
      "password": "$password",
    };
    return await APIs.postRequest(url, body);
  }
}
