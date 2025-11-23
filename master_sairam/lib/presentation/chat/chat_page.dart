import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/chat_message.dart';
import 'cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  final int chatId;
  const ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().load(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Чат')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) return const Center(child: CircularProgressIndicator());
                if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(AppConstants.padding),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages.reversed.toList()[index];
                      final align = message.isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                      final color = message.isOwner ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.white;
                      return Column(
                        crossAxisAlignment: align,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
                            ),
                            child: Column(
                              crossAxisAlignment: align,
                              children: [
                                if (!message.isOwner)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(message.sender, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  ),
                                Text(message.text),
                                const SizedBox(height: 4),
                                Text('${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.padding),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.photo_outlined)),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'Сообщение'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;
                      final message = ChatMessage(
                        id: DateTime.now().millisecondsSinceEpoch,
                        sender: 'Вы',
                        text: text,
                        time: DateTime.now(),
                        isOwner: true,
                      );
                      context.read<ChatCubit>().send(widget.chatId, message);
                      controller.clear();
                    },
                    icon: const Icon(Icons.send, color: Colors.teal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
