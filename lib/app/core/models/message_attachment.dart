// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageAttachment {
  String attachmentType;
  String attachmentText;
  String attachmentLink;
  String attachmentSize;
  String thumbnailUrl;
  MessageAttachment({
    required this.attachmentType,
    required this.attachmentText,
    required this.attachmentLink,
    required this.attachmentSize,
    required this.thumbnailUrl,
  });

  factory MessageAttachment.empty() {
    return MessageAttachment(
      attachmentType: '',
      attachmentText: '',
      attachmentLink: '',
      attachmentSize: '',
      thumbnailUrl: '',
    );
  }

  MessageAttachment copyWith({
    String? attachmentType,
    String? attachmentText,
    String? attachmentLink,
    String? attachmentSize,
    String? thumbnailUrl,
  }) {
    return MessageAttachment(
      attachmentType: attachmentType ?? this.attachmentType,
      attachmentText: attachmentText ?? this.attachmentText,
      attachmentLink: attachmentLink ?? this.attachmentLink,
      attachmentSize: attachmentSize ?? this.attachmentSize,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attachmentType': attachmentType,
      'attachmentText': attachmentText,
      'attachmentLink': attachmentLink,
      'attachmentSize': attachmentSize,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory MessageAttachment.fromMap(Map<String, dynamic> map) {
    return MessageAttachment(
      attachmentType: map['attachmentType'] ?? "",
      attachmentText: map['attachmentText'] ?? "",
      attachmentLink: map['attachmentLink'] ?? "",
      attachmentSize: map['attachmentSize'] ?? "",
      thumbnailUrl: map['thumbnailUrl'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageAttachment.fromJson(String source) =>
      MessageAttachment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageAttachment(attachmentType: $attachmentType, attachmentText: $attachmentText, attachmentLink: $attachmentLink, attachmentSize: $attachmentSize, thumbnailUrl: $thumbnailUrl)';
  }

  @override
  bool operator ==(covariant MessageAttachment other) {
    if (identical(this, other)) return true;

    return other.attachmentType == attachmentType &&
        other.attachmentText == attachmentText &&
        other.attachmentLink == attachmentLink &&
        other.attachmentSize == attachmentSize &&
        other.thumbnailUrl == thumbnailUrl;
  }

  @override
  int get hashCode {
    return attachmentType.hashCode ^
        attachmentText.hashCode ^
        attachmentLink.hashCode ^
        attachmentSize.hashCode ^
        thumbnailUrl.hashCode;
  }
}
