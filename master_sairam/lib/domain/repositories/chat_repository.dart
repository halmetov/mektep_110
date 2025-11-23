import '../entities/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessages(int chatId);
  Future<void> sendMessage(int chatId, ChatMessage message);
}
