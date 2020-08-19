import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class APIs {
  static String baseUrl = 'http://ertaho.site/api/';
  static String imageBaseUrl = 'http://ertaho.site/public/dash/assets/img/';
  static String imageProfileUrl = 'http://ertaho.site/public/dash/assets/img/';
//AIzaSyDyZS1lXwrSQfLucsqjh2_XrTlm-ZkHjNU

  static String registerEP = '${baseUrl}userregister';
  static String loginEP = '${baseUrl}userlogin';
  static String phoneVerifyEP = '${baseUrl}phone-verify';
  static String rechangepassEP = '${baseUrl}rechangepass';
  static String editpassEP = '${baseUrl}editpass';
  static String sendForgetPasswordEP = '${baseUrl}send-forget-password';
  static String verifyForgetPasswordEP = '${baseUrl}verify-forget-password';
  static String resendVerifyEP = '${baseUrl}resend-phone-verify';
  static String updateNotifyEP = '${baseUrl}updatenotify';
  static String editDeliveryProfileEP = '${baseUrl}editdeliveryprofile';

  static String homeEP = '${baseUrl}home';
  static String wantedEP = '${baseUrl}manywanted';
  static String nearestEP = '${baseUrl}nearest';
  static String showRestoEP = '${baseUrl}showrestaurant';
  static String showProductEP = '${baseUrl}showproduct';
  static String makeOrderEP = '${baseUrl}makeOrder';
  static String checkcoponEP = '${baseUrl}checkcopon';
  static String finishorderEP = '${baseUrl}finishorder';
  static String userinitordersEP = '${baseUrl}userinitorders';
  static String userfinishordersEP = '${baseUrl}userfinishorders';
  static String deliveryoffersEP = '${baseUrl}deliveryoffers';
  static String confirmOfferEP = '${baseUrl}confirmorder';
  static String showOrderEP = '${baseUrl}showorder';

  static String adddeliveryrateEP = '${baseUrl}adddeliveryrate';

  static String profileEP = '${baseUrl}profile';
  static String editprofileEP = '${baseUrl}editprofile';
  static String addcontactEP = '${baseUrl}addcontact';
  static String settinginfoEP = '${baseUrl}settinginfo';
  static String paymentsEP = '${baseUrl}payments';

  static Future getRequest(url,
      {String token = '', BuildContext context}) async {
    // String _token;
    // final reactiveModel = Injector.getAsReactive<AuthStore>();
    String _token = IN.get<AuthStore>().credentialsModel?.data?.apiToken;
    // _token = _token?? reactiveModel.state.unConfirmedcredentialsModel?.data?.apiToken;
    _token= 
        'HyLHX11fjuufMz6O2mx2eJhxhBcI4sYkUZDVyAKCrxI9MaQniJCvpg1JLkx2rfj2z4WgVEn6R8Ew259S1gzQPkmJcO4hODMxAORL';

    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      return checkResponse(response);
    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future postRequest(String url, Map<String, dynamic> body,
      {BuildContext context}) async {
    String _token;
    // final reactiveModel = Injector.getAsReactive<AuthStore>();
    //  String _token = reactiveModel.state.credentialsModel?.data?.apiToken;
    // _token = _token?? reactiveModel.state.unConfirmedcredentialsModel?.data?.apiToken;
    _token = _token ??
        'BbONzSn1X0h7fmBLZ5Xy83coeRM09LpznsfG8T8YkNPnrJzzpuwPTFT3JKrGjkTU1XtUnyQGqcv9gpMQ7w9HPkPVAqjW2JhH51GU';

    print('Posting request');
    print(body);

    try {
      final response = await http
          .post(url, body: body, headers: {'Authorization': 'Bearer $_token'});
      return checkResponse(response);
    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print('post request eror $e');
      rethrow;
    }
  }

  static postWithFile(
    String urlString,
    Map<String, String> body, {
    String filePath,
    String fileName,
    List additionalData,
    String additionalDataField,
    List additionalFiles,
    List additionalFilesNames,
    String additionalFilesField,
  }) async {
    String _token;
    print('Posting with files');
    // final reactiveModel = Injector.getAsReactive<AuthStore>();
    // String _token = reactiveModel.state.credentialsModel?.data?.apiToken;
    // _token = _token??
    //     'c8GoLrSvefAfqfb2BJ5VXUOUJrSybNAcAd2LeQsNFPGHN60ejuDEV64sSQNblAx75eDpEvz8zFJwe2p6DUkrYjk3LNsimclr6b2v';

    Uri url = Uri.parse(urlString);
    // String image = savedOccasion['image'];
    // Map<String, String> body = (savedOccasion); //.toJson();
    Map<String, String> header = {'Authorization': 'Bearer $_token'};
    http.MultipartRequest request = http.MultipartRequest('post', url);
    request.fields.addAll(body);
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      print('Had File');
    }
    if (additionalFiles != null && additionalFiles.isNotEmpty)
      for (int i = 0; i < additionalFiles.length; i++) {
        print('additionalFiles[i]');
        request.files.add(http.MultipartFile.fromBytes(
            '$additionalFilesField[$i]', additionalFiles[i],
            filename: '${additionalFilesNames[i]}'));
      }
    if (additionalData != null && additionalData.isNotEmpty)
      for (int i = 0; i < additionalData.length; i++) {
        request.fields['$additionalDataField[$i]'] =
            additionalData[i].toString();
      }
    request.headers.addAll(header);
    print(body);
    try {
      final response = await request.send();
      final responseData =
          json.decode(utf8.decode(await response.stream.first));

      print('Response from post with image $responseData}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        // final responseData = (json.decode(utf8.decode(onData)));

        print(responseData);
        if (responseData['msg'].toString().toLowerCase() == 'success') {
          print(responseData);
          return (responseData);
        } else {
          if (responseData['msg'].toString().contains('unauth'))
            throw 'من فضلك تأكد من تسجيل الدخول';
          else
            throw responseData['data'];
        }
      } else
        throw 'تعذر الإتصال';

      // return SaveOccasionModel.fromJson(
      //     APIs.checkResponse(json.decode(utf8.decode(onData))));

    } on SocketException catch (e) {
      print(e);
      throw 'تحقق من اتصالك بالانترنت';
    } on HttpException catch (e) {
      print(e);
      throw 'تعذر الاتصال بالخادم';
    } on FormatException catch (e) {
      print(e);
      throw 'Bad response';
    } catch (e) {
      print(e);
      throw '$e';
    }
  }

  static checkResponse(http.Response response) {
    print('checking response');
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);

      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else {
        if (responseData['msg'].toString().contains('unauth'))
          throw 'من فضلك تأكد من تسجيل الدخول';
        else
          throw responseData['data'];
      }
    } else
      throw 'تعذر الإتصال';
  }
}
