class ContactModel {
  late String userId, name, contact_number,  email ;

  ContactModel({
    required this.name,
    required this.userId,
    required this.contact_number,

    required this.email,
  });

  ContactModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['userId'];
    name = map['name'];
    contact_number = map['contact_number'];

    email = map['email'];
   }

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'contact_number': contact_number,

      'email': email,
    };
  }
}
