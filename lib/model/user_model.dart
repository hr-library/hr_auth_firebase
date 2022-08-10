import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  bool? enable;
  String? userType;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photo;
  String? locationStorage;
  User? user;

  UserModel({
    required this.uid,
    required this.enable,
    required this.userType,
    required this.user,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
    required this.photo,
    required this.locationStorage,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userType = json['userType'];
    enable = json['enable'];
    user = json['user'];
    email = json['email'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    photo = json['photo'];
    locationStorage = json['locationStorage'];
  }

  copyWith({
    String? uid,
    bool? enable,
    String? userType,
    String? email,
    String? displayName,
    String? name,
    User? user,
    String? phoneNumber,
    String? photo,
    String? locationStorage,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        enable: enable ?? this.enable,
        userType: userType ?? this.userType,
        user: user ?? this.user,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photo: photo ?? this.photo,
        locationStorage: locationStorage ?? this.locationStorage,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['enable'] = enable;
    data['userType'] = userType;
    data['email'] = email;
    data['displayName'] = displayName;
    data['phoneNumber'] = phoneNumber;
    data['photo'] = photo;
    data['locationStorage'] = locationStorage;
    return data;
  }
}
