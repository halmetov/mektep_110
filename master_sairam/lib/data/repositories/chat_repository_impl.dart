import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final Map<int, List<ChatMessage>> _chats = {
    1: [
      ChatMessage(id: 1, sender: 'Заказчик', text: 'Здравствуйте! Сколько будет стоить?', time: DateTime.now().subtract(const Duration(minutes: 20))),
      ChatMessage(id: 2, sender: 'Вы', text: 'Добрый день! 18 000, смогу завтра.', time: DateTime.now().subtract(const Duration(minutes: 15)), isOwner: true),
    ],
  };

  @override
  Future<List<ChatMessage>> getMessages(int chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.of(_chats[chatId] ?? []);
  }

  @override
  Future<void> sendMessage(int chatId, ChatMessage message) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _chats.putIfAbsent(chatId, () => []); 
    _chats[chatId]!.add(message);
  }
}
