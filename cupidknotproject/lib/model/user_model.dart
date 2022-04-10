class UserModel {
  late String userId,
      email,
      name,
      full_name,
      mobile_no,
      email_verified_at,
      gender,
      dob;


  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.full_name,
    required this.mobile_no,
    required this.email_verified_at,
    required this.gender,
    required this.dob,

  });

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['id'].toString();
    email = map['email'];
    name = map['name'];
    full_name = map['full_name'];
    mobile_no = map['mobile_no'];
    email_verified_at = map['email_verified_at'] == null ? " " : map['email_verified_at'];
    gender = map['gender'];
    dob = map['dob'];

  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'full_name': full_name,
      'mobile_no': mobile_no,
      'email_verified_at': email_verified_at,
      'gender': gender,
      'dob': dob,

    };
  }
}
