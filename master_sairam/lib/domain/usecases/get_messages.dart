import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Future<List<ChatMessage>> call(int chatId) => repository.getMessages(chatId);
}
