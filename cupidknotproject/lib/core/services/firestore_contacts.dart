import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupidknotproject/model/contact_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreCheckout {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _contactsCollection = FirebaseFirestore.instance
      .collection('contacts');

  Future<List<QueryDocumentSnapshot>> getOrdersFromFirestore() async {
    var _contacts =
        await _contactsCollection.get();
    return _contacts.docs;
  }

  addContactToFirestore(ContactModel contact) async {
    await _contactsCollection.doc().set(contact.toJson());
  }
}
