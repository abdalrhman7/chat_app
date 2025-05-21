import 'package:chat_app/feature/conversation/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel(
      {required super.id,
      required super.participantName,
      required super.lastMessage,
      required super.lastMessageTime});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final String? timeString = json['last_message_time'] as String?;

    return ConversationModel(
      id: json['conversation_id'] as String,
      participantName: json['participant_name'] as String,
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: timeString != null
          ? DateTime.parse(timeString)
          : DateTime.now(),
    );
  }

}


class ConversationIdResponse {
  final String conversationId;

  ConversationIdResponse({required this.conversationId});

  factory ConversationIdResponse.fromJson(Map<String, dynamic> json) {
    return ConversationIdResponse(
      conversationId: json['conversationId'] as String,
    );
  }

}


