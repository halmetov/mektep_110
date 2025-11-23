import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.sender,
    required super.text,
    required super.time,
    super.isOwner = false,
    super.imageUrl,
  });
}
