
import 'package:cupidknotproject/routes/urlroutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../services/local_storage_user.dart';
import '../services/firestore_user.dart';
import '../../model/user_model.dart';
import '../../view/control_view.dart';
import 'package:dio/dio.dart';
class AuthViewModel extends GetxController {
  String? email, password,c_password, name,
      mobile_no,
      gender,
      dob;
  var selectedDate = DateTime.now().obs;
  Rxn<String>? _user = Rxn<String>(GetStorage().read('user').toString());

  String? get user => _user!.value;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        //initialEntryMode: DatePickerEntryMode.input,
        // initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select DOB',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Month/Date/Year',
       );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      update();
    }

  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  void signUpWithEmailAndPassword() async {
    try {
      print(dob);
      print(gender);
      Dio dio =new Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));;
      var response = await dio.post(Routes.BASEURL+'register',
          data: {'email': email!, 'password': password!,
            'c_password':c_password!,'full_name': name!,
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

  void signInWithEmailAndPassword() async {
    try {

      Dio dio =new Dio(BaseOptions(contentType: Headers.jsonContentType,responseType: ResponseType.json,validateStatus: (_)=>true,));;
      var response = await dio.post(Routes.BASEURL+'login', data: {'email': email!, 'password': password!});
      if (response.data['success'] == true){
        saveUserLocal(
            response.data['data']['user_details']);
        GetStorage().write('token', response.data['data']['token']);
        GetStorage().write('userId', response.data['data']['user_details']['id']);
        Get.offAll(ControlView());
        Get.snackbar(
          'Login Successfully',
          "you have logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

      }

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



  void signOut() async {
    try {
      GetStorage().erase();
      Get.offAll(ControlView());
    } catch (error) {
      print(error);
    }
  }


  void saveUserLocal(userModel) async {

    GetStorage().write('user', userModel);
  }
}
