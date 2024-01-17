// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class ChatRoomModel {
  String id;
  Timestamp createdAt;
  List<String> participantIds;
  List<UserModel> participantsList;
  String lastMessage;
  String lastMessageID;
  Timestamp lastMessageTime;
  String senderId;
  String lastMessageType;
  int unSeenMessage;
  ChatRoomModel({
    required this.id,
    required this.createdAt,
    required this.participantIds,
    required this.participantsList,
    required this.lastMessage,
    required this.lastMessageID,
    required this.lastMessageTime,
    required this.senderId,
    required this.lastMessageType,
    required this.unSeenMessage,
  });

  factory ChatRoomModel.empty() {
    return ChatRoomModel(
      id: '',
      createdAt: Timestamp.now(),
      participantIds: [],
      participantsList: [],
      lastMessage: '',
      lastMessageID: '',
      lastMessageTime: Timestamp.now(),
      senderId: '',
      lastMessageType: '',
      unSeenMessage: 0,
    );
  }

  ChatRoomModel copyWith({
    String? id,
    Timestamp? createdAt,
    List<String>? participant,
    List<UserModel>? participantsList,
    String? lastMessage,
    String? lastMessageID,
    Timestamp? lastMessageTime,
    String? profilePicture,
    String? lastMessageType,
    int? unSeenMessage,
  }) {
    return ChatRoomModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      participantIds: participant ?? participantIds,
      participantsList: participantsList ?? this.participantsList,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageID: lastMessageID ?? this.lastMessageID,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      senderId: profilePicture ?? senderId,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      unSeenMessage: unSeenMessage ?? this.unSeenMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'participantIds': participantIds,
      'participantsList': participantsList.map((x) => x.toMap()).toList(),
      'lastMessage': lastMessage,
      'lastMessageID': lastMessageID,
      'lastMessageTime': lastMessageTime,
      'senderId': senderId,
      'lastMessageType': lastMessageType,
      'unSeenMessage': unSeenMessage,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      participantIds: List<String>.from((map['participantIds'] ?? [])),
      participantsList: map['participantsList'] != null
          ? (map['participantsList'] as List<dynamic>)
              .map((x) => UserModel.fromMap(x))
              .toList()
          : [],
      lastMessage: map['lastMessage'] ?? "",
      lastMessageID: map['lastMessageID'] ?? "",
      lastMessageTime: map['lastMessageTime'] ?? Timestamp.now(),
      senderId: map['senderId'] ?? "",
      lastMessageType: map['lastMessageType'] ?? "",
      unSeenMessage: map['unSeenMessage'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatRoomModel(id: $id, createdAt: $createdAt, participantIds: $participantIds, participantsList: $participantsList, lastMessage: $lastMessage, lastMessageID: $lastMessageID, lastMessageTime: $lastMessageTime,  senderId: $senderId, lastMessageType: $lastMessageType, unSeenMessage: $unSeenMessage)';
  }
}
