part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final int chatId;
  final List<ChatMessage> messages;

  ChatLoaded({required this.chatId, required this.messages});

  @override
  List<Object?> get props => [chatId, messages];
}
