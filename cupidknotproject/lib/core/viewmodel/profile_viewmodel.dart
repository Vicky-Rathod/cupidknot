import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../routes/urlroutes.dart';
import '../../view/control_view.dart';
import '../services/firestore_user.dart';
import '../services/local_storage_user.dart';
import '../../model/user_model.dart';

class ProfileViewModel extends GetxController {
  UserModel? _currentUser;
  String? full_name, email, password, picUrl;
  String? c_password,
      mobile_no,
      gender,
      dob;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }
  getCurrentUser() async {
    _loading = true;
    _currentUser = await LocalStorageUser.getUserData();
    _loading = false;
    update();
  }

  updateCurrentUser() async {

      try {

        Dio dio =new Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));;
        var response = await dio.post(Routes.BASEURL+'updateProfileDetails',
            data: {'email': email!, 'full_name': full_name!,
              'mobile_no':mobile_no!,
              'gender':[gender!],
              'dob': DateFormat('Y-m-d').format(DateTime.parse(dob!))});
        print(response.data);
        if (response.data['success'] == true){
          saveUserLocal(
              response.data['data']['user_details']);
          GetStorage().write('token', response.data['data']['token']);
          Get.offAll(ControlView());
          Get.snackbar(
            'Registered Successfully',
            "you have registered successfully",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        else{
          Get.snackbar(
            'Registered Unsuccessful',
            response.data,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        Get.offAll(ControlView());
      } catch (error) {
        print(error);
        String errorMessage =
        error.toString().substring(error.toString().indexOf(' ') + 1);
        Get.snackbar(
          'Failed to login..',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
  }
  void saveUserLocal(userModel) async {

    GetStorage().write('user', userModel);
  }
}
