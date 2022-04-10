import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/contact_list.dart';
import '../services/firestore_user.dart';
import '../services/local_storage_user.dart';
import '../../model/user_model.dart';

class ContactViewModel extends GetxController {
  UserModel? _currentUser;
  String? name, email, mobile_no;

  UserModel? get currentUser => _currentUser;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
  }
  final CollectionReference _contactCollection =
  FirebaseFirestore.instance.collection('contacts');

  addContactToFirestore() async {
    await _contactCollection.doc().set(ContactModel(name: name!, userId: 20.toString(), contact_number: mobile_no!, email: email!).toJson());
    Get.back();
  }

  addContactDetails() async {
    try {
      ContactModel _userModel = ContactModel(
        userId: _currentUser!.userId,
        email: email!,
        name: name!,
        contact_number: mobile_no!,
      );
      Get.back();
    } catch (error) {
      String errorMessage =
      error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Failed to update..',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
