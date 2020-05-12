import 'package:flutter/material.dart';

class User {
  User(
      {@required this.uid,
      @required this.email,
      this.photoUrl = '',
      this.displayName = '名無しさん',
      this.providerData,
      this.lastSignInTime,
      this.description = 'よろしくおねがいします。'});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'].toString(),
      email: json['email'].toString(),
      displayName: json['displayName'].toString(),
      photoUrl: json['photoUrl'].toString(),
      providerData: json['providerData'].toString(),
      lastSignInTime: json['lastSignInTime'].toString(),
      description: json['description'].toString(),
    );
  }

//  in sns login, get fire base auth.
  String uid;
  String email;
  String photoUrl;
  String displayName;
  String providerData;
  String lastSignInTime;

//  custom data.
  String description;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'displayName': displayName,
        'providerData': providerData,
        'lastSignInTime': lastSignInTime.toString(),
        'description': description,
      };
}
