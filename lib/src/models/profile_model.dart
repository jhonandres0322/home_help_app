// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

ProfileModel profileFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String uID;
  String firstname;
  String lastname;
  String documentNumber;
  String profilePicture;
  String phone;
  String address;
  String birthdate;
  String user;
  String rol;
  String bio;

  ProfileModel({
    this.uID,
    this.firstname,
    this.lastname,
    this.documentNumber,
    this.profilePicture = "",
    this.phone,
    this.address,
    this.birthdate,
    this.user,
    this.rol,
    this.bio
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        uID: json["uID"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        documentNumber: json["document_number"],
        profilePicture: json["profile_picture"],
        phone: json["phone"],
        address: json["address"],
        birthdate: json["birthdate"],
        user: json["user"],
        rol: json["rol"],
        bio: json["bio"]
      );

  Map<String, dynamic> toJson() => {
        "uID": uID,
        "firstname": firstname,
        "lastname": lastname,
        "document_number": documentNumber,
        "profile_picture": profilePicture,
        "phone": phone,
        "address": address,
        "birthdate": birthdate,
        "user": user,
        "rol": rol,
        "bio": bio,
      };
}
