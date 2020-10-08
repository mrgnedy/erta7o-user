import 'package:request_mandoub/core/api_utils.dart';

class AuthRepo {
  Future registerUser(Map<String, dynamic> body) async {
    final String url = APIs.registerEP;
    return await APIs.postRequest(url, body);
  }

  Future login(Map<String, dynamic> body) async {
    final String url = APIs.loginEP;
    return await APIs.postRequest(url, body);
  }

  Future verify(String code, String phone) async {
    String url = APIs.phoneVerifyEP;
    Map<String, dynamic> body = {'code': '$code', 'phone': '$phone'};
    return await APIs.postRequest(url, body);
  }

  Future forgetPassword(String phone) async {
    String url = APIs.sendForgetPasswordEP;
    Map<String, dynamic> body = {'phone': '$phone'};
    return await APIs.postRequest(url, body);
  }

  Future verifyForgetPassword(String phone, String code) async {
    String url = APIs.verifyForgetPasswordEP;
    Map<String, dynamic> body = {'phone': '$phone', 'code': '$code'};
    return await APIs.postRequest(url, body);
  }

  Future rechangePassword(String phone, String password) async {
    String url = APIs.rechangepassEP;
    Map<String, dynamic> body = {
      'phone': '$phone',
      'new_pass': '$password',
      'confirm_pass': '$password',
    };
    return await APIs.postRequest(url, body);
  }

  Future resendVerify(String phone) async {
    String url = APIs.resendVerifyEP;
    Map<String, dynamic> body = {'phone': phone};
    return await APIs.postRequest(url, body);
  }

  Future editPhone(String phone) async {
    String url = APIs.editDeliveryProfileEP;
    Map<String, dynamic> body = {'phone': phone};
    return await APIs.postRequest(url, body);
  }

  Future editPassword(String oldPassword, String newPassword) async {
    String url = APIs.editpassEP;
    Map<String, dynamic> body = {
      'old_password': '$oldPassword',
      'password': '$newPassword',
    };
    return await APIs.postRequest(url, body);
  }

  Future updateNotify(notifStatus) async {
    String url = APIs.updatenotifyEP;
    Map<String, dynamic> body = {'updatenotify': "$notifStatus"};
    return await APIs.postRequest(url, body);
  }

  Future updateLocation(lat, long, address) async {
    String url = APIs.updatelocationEP;
    Map<String, dynamic> body = {
      'lat': "$lat",
      "lng": "$long",
      "address": "$address"
    };
    return await APIs.postRequest(url, body);
  }
}
