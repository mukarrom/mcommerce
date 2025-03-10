import 'dart:convert';

import 'package:m_commerce/features/auth/data/models/user_model.dart';
import 'package:m_commerce/features/common/ui/utils/verify_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _accessTokenKey = 'accessToken';
  final String _profileDataKey = 'userData';

  String? accessToken;
  UserModel? userModel;

  Future<void> saveUserData(String accessToken, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(
      _profileDataKey,
      jsonEncode(model.toJson()),
    );
    userModel = model;
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    userModel = UserModel.fromJson(
      jsonDecode(sharedPreferences.getString(_profileDataKey)!),
    );
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(_accessTokenKey) != null) {
      await getUserData();
      if (verifyToken(accessToken)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void logout() {
    SharedPreferences.getInstance().then((value) {
      value.remove(_accessTokenKey);
      value.remove(_profileDataKey);
    });

    accessToken = null;
    userModel = null;
  }
}
