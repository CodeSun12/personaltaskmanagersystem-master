

import 'dart:typed_data';

class FriendsModel {
  final int? id;
  final String fName;
  final String lName;
  final int age;
  final String? address;
  final String? gender;

  FriendsModel({
        this.id,
        required this.fName,
        required this.lName,
        required this.age,
        required this.address,
        required this.gender,
      });

  FriendsModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        fName = res["fName"],
        lName = res["lName"],
        age = res["age"],
        address = res["address"],
        gender = res['gender'];

  Map<String, Object?> toMap() {
    return {'id':id,'fName': fName, 'lName': lName, 'age': age, 'address': address, 'gender': gender};
  }
}