import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupidknotproject/model/contact_list.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/firestore_home.dart';



class HomeViewModel extends GetxController {

  List<ContactModel> _contact = [];


  List<ContactModel> get contacts => _contact;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getContactsFromFireStore();
  }



  getContactsFromFireStore() async {
    _loading = true;
    List<QueryDocumentSnapshot> contactsSnapshot =
        await FirestoreHome().getContactFromFirestore();
    contactsSnapshot.forEach((contact) {

      _contact
          .add(ContactModel.fromJson(contact.data() as Map<String, dynamic>));
    });
    print(contactsSnapshot);
    _loading = false;
    update();
  }
}
