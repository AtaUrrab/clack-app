import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String userId;
  final Timestamp createdAt;
  final String name;
  final String userName;
  final String userBio;
  final String email;
  final String token;
  final bool isOnline;
  final bool isVerifiedAccount;
  final String profilePicture;

  final bool isSeenMessage;
  UserModel({
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.userName,
    required this.userBio,
    required this.email,
    required this.token,
    required this.isOnline,
    required this.isVerifiedAccount,
    required this.profilePicture,
    required this.isSeenMessage,
  });

  factory UserModel.empty() {
    return UserModel(
      userId: '',
      createdAt: Timestamp.now(),
      name: '',
      userName: '',
      userBio: '',
      email: '',
      token: '',
      isOnline: false,
      isVerifiedAccount: false,
      profilePicture: '',
      isSeenMessage: false,
    );
  }

  UserModel copyWith({
    String? userId,
    Timestamp? createdAt,
    String? name,
    String? userName,
    String? userBio,
    String? email,
    String? token,
    bool? isOnline,
    bool? isVerifiedAccount,
    String? profilePicture,
    List<String>? friendsList,
    bool? isSeenMessage,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      userBio: userBio ?? this.userBio,
      email: email ?? this.email,
      token: token ?? this.token,
      isOnline: isOnline ?? this.isOnline,
      isVerifiedAccount: isVerifiedAccount ?? this.isVerifiedAccount,
      profilePicture: profilePicture ?? this.profilePicture,
      isSeenMessage: isSeenMessage ?? this.isSeenMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'createdAt': createdAt,
      'name': name,
      'userName': userName,
      'userBio': userBio,
      'email': email,
      'token': token,
      'isOnline': isOnline,
      'isVerifiedAccount': isVerifiedAccount,
      'profilePicture': profilePicture,
      'isSeenMessage': isSeenMessage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      name: map['name'] ?? "",
      userName: map['userName'] ?? "",
      userBio: map['userBio'] ?? "",
      email: map['email'] ?? "",
      token: map['token'] ?? "",
      isOnline: map['isOnline'] ?? false,
      isVerifiedAccount: map['isVerifiedAccount'] ?? false,
      profilePicture: map['profilePicture'] ?? "",
      isSeenMessage: map['isSeenMessage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, createdAt: $createdAt, name: $name, userName: $userName, userBio: $userBio, email: $email, token: $token, isOnline: $isOnline, isVerifiedAccount: $isVerifiedAccount, profilePicture: $profilePicture, isSeenMessage: $isSeenMessage)';
  }
}
