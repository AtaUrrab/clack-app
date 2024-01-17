import 'dart:convert';

import 'package:clack_app/app/core/models/message_attachment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageModel {
  String id;
  Timestamp createdAt;
  String message;
  String chatRoomId;
  String senderId;
  String status;
  MessageAttachment messageAttachment;
  MessageModel({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.chatRoomId,
    required this.senderId,
    required this.status,
    required this.messageAttachment,
  });

  factory MessageModel.empty() {
    return MessageModel(
      id: '',
      createdAt: Timestamp.now(),
      message: '',
      senderId: '',
      chatRoomId: '',
      status: '',
      messageAttachment: MessageAttachment.empty(),
    );
  }

  MessageModel copyWith({
    String? id,
    Timestamp? createdAt,
    String? message,
    String? chatRoomId,
    String? senderId,
    String? status,
    MessageAttachment? messageAttachment,
  }) {
    return MessageModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ?? this.senderId,
      status: status ?? this.status,
      messageAttachment: messageAttachment ?? this.messageAttachment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'message': message,
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'status': status,
      'messageAttachment': messageAttachment.toMap(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      message: map['message'] ?? "",
      chatRoomId: map['chatRoomId'] ?? "",
      senderId: map['senderId'] ?? "",
      status: map['status'] ?? "",
      messageAttachment: MessageAttachment.fromMap(
        map['messageAttachment'] ?? MessageAttachment.empty(),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, createdAt: $createdAt, message: $message, chatRoomId: $chatRoomId, senderId: $senderId, status: $status, messageAttachment: $messageAttachment)';
  }
}
