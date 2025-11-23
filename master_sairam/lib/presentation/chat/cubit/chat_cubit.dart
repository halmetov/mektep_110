import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/usecases/get_messages.dart';
import '../../../domain/usecases/send_message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;

  ChatCubit({required this.getMessages, required this.sendMessage}) : super(ChatLoading());

  Future<void> load(int chatId) async {
    emit(ChatLoading());
    final items = await getMessages(chatId);
    emit(ChatLoaded(chatId: chatId, messages: items));
  }

  Future<void> send(int chatId, ChatMessage message) async {
    if (state is ChatLoaded) {
      final current = (state as ChatLoaded).messages;
      emit(ChatLoaded(chatId: chatId, messages: [...current, message]));
    }
    await sendMessage(chatId, message);
  }
}
