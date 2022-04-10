import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '../../model/user_model.dart';

class LocalStorageUser {

  static setUserData(userModel) async {
    final box = GetStorage();
    await box.write('user',  userModel);
  }

  static Future<UserModel> getUserData() async {

    return UserModel.fromJson(
        GetStorage().read('user'));
  }

  static clearUserData() async {

    await GetStorage().erase();
  }
}
