import 'dart:convert';

import 'package:request_mandoub/data/models/credentials_model.dart';
import 'package:request_mandoub/data/repository/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

enum AuthMode { login, register }

class AuthStore {
  final AuthRepo authRepo;
  AuthStore(this.authRepo) {
    SharedPreferences.getInstance().then((shPref) {
    checkForSavedCredentials();
      pref=shPref;
    });
  }

  bool get isAuth => credentialsModel != null;
  AuthMode authMode = AuthMode.login;
  SharedPreferences pref;
  CredentialsModel credentialsModel;
  CredentialsModel authModel = CredentialsModel(data: Credential());
  // RMKey<AuthStore> registerKey = RMKey();
  TextEditingController locationCtrler = TextEditingController();
  // GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  Future<bool> checkForSavedCredentials() async {
    if (credentialsModel != null) return Future.sync(() => true);
    return await SharedPreferences.getInstance().then((shPref) {
      pref = shPref;
      if (shPref.getString('creds') != null) {
        final tempCreds =
            CredentialsModel.fromJson(json.decode(shPref.getString('creds')));
        if (tempCreds.data.confirmed == 1) credentialsModel = tempCreds;
        // else
        //   unConfirmedcredentialsModel = tempCreds;
      }
      if (credentialsModel == null) {
        print('Is Not Authenticated!');
        return false;
      } else {
        print('Is Authenticated with data: ${credentialsModel.data.toJson()}');

        return true;
      }
    });
  }

  Future<CredentialsModel> register() async {
    return CredentialsModel.fromJson(
        await authRepo.registerUser(authModel.data.register()));
  }

  Future<CredentialsModel> login() async {
    final tempCreds =
        CredentialsModel.fromJson(await authRepo.login(authModel.data.login()));
    if (tempCreds?.data?.confirmed == 1) {
      credentialsModel = tempCreds;
      pref.setString('creds', json.encode(credentialsModel.toJson()));
    }
    return tempCreds;
  }

  Future<CredentialsModel> verify() async {
    credentialsModel = CredentialsModel.fromJson(
        await authRepo.verify(authModel.verifynumber, "+966"+authModel.data.phone));
    if (credentialsModel != null)
      pref.setString(
        'creds',
        json.encode(credentialsModel.toJson()),
      );

    return credentialsModel;
  }

  Future<String> resendVerify() async {
    final temp = (await authRepo.resendVerify("+966"+authModel.data.phone));
    final tempCode = temp['data']['verifynumber'].toString();
    print('THIS IS VERIFY CODE: $temp');
    return tempCode;
  }

  Future<String> sendForgetPassword() async {
    final String verifyNum = (await authRepo
            .forgetPassword("+966"+authModel.data.phone))['data']['verifyNum']
        .toString();
    print('THIS IS VERIFY CODE: $verifyNum');
    return verifyNum;
  }

  Future<CredentialsModel> verifyForgetPasowrd() async {
    final cred = CredentialsModel.fromJson(await authRepo.verifyForgetPassword(
        "+966"+authModel.data.phone, authModel.verifynumber));
    credentialsModel = cred;
    pref.setString('creds', json.encode(credentialsModel.toJson()));
    return cred;
  }

  Future rechangePassowrd() async {
    // final creds = CredentialsModel.fromJson(await authRepo.rechangePassword(
    //     authModel.data.phone, authModel.data.password));
    // credentialsModel = creds;
    // pref.setString('creds', json.encode(credentialsModel.toJson()));
    // return creds;
    return await authRepo.rechangePassword(
        "+966"+authModel.data.phone, authModel.data.password);
  }

  Future editPass(String password) async {
    return await authRepo.editPassword(password, password);
  }

  Future editProfile(String phone) async {
    final creds = CredentialsModel.fromJson(await authRepo.editPhone(phone));
    credentialsModel = creds;
    pref.setString('creds', json.encode(credentialsModel.toJson()));
    return creds;
  }

  Future updateNotify(notifStatus) async {
    return await authRepo.updateNotify(notifStatus);
  }
  Future updateLocation(lat, long, address) async {
    return await authRepo.updateLocation(lat, long, address);
  }
}
