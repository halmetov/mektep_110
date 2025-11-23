import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final int id;
  final String sender;
  final String text;
  final DateTime time;
  final bool isOwner;
  final String? imageUrl;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    this.isOwner = false,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, sender, text, time, isOwner, imageUrl];
}
