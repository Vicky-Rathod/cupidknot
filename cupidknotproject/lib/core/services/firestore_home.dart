import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupidknotproject/model/contact_list.dart';
import 'package:get_storage/get_storage.dart';

class FirestoreHome {


final _contactsCollection =
      FirebaseFirestore.instance.collection('contacts');
  Future<List<QueryDocumentSnapshot>> getContactFromFirestore() async {

    var contacts = await _contactsCollection.where('userId',isEqualTo:GetStorage().read('userId').toString()).get();
    print(contacts.docs);
    return contacts.docs;
  }
}
