import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:langpal_prototype/types/ai_partner.dart';
import 'package:langpal_prototype/types/user_notifier.dart';
import 'package:provider/provider.dart';

import '../types/user.dart';
import '../types/chat_message.dart';
import 'message_service.dart';



class ChatContainer extends StatefulWidget {
  List<ChatMessage> messages;
   ChatContainer({
    super.key, 
    required this.messages,
  });

@override
  State<ChatContainer> createState() => _ChatContainer();
}
class _ChatContainer extends State<ChatContainer>{
  final ScrollController? scrollController = ScrollController();
  //late StreamSubscription<ChatMessage> _subscription;
 
  @override
void initState() {
  super.initState();

}

@override
void dispose(){
 // _subscription.cancel();
  scrollController?.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: 300,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 0.5,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(12),
          itemCount: widget.messages.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final message = widget.messages[index];
            return MessageBubble(
              message: message.text,
              isUser: message.isFromUser,
            );
          },
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? Color.fromARGB(255, 7, 172, 190) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}

class ChatInput extends StatefulWidget {
  final AiPartner aiPartner;
  const ChatInput({Key? key, required this.aiPartner}) : super(key: key);
  

  @override
  State<ChatInput> createState() => _ChatInputState();
}
class _ChatInputState extends State<ChatInput> {
  
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  late final String fileContents;

  @override initState(){
    super.initState();
  
  }

  Widget build(BuildContext context) {
    //String userId = context.read<UserNotifier>().user!.id;
    User user = context.watch<UserNotifier>().user!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8.0),
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 7, 172, 190),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Send message logic
                if (_textController.text.trim().isNotEmpty) {
                  setState(() {
                    //send new message object to list of messages in ChatContainer;
                    _sendMessage(true, _textController.text, user.id);
                   _textController.clear();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  void _sendMessage(bool isUser, String text, String userId) {
    final ChatMessage message = ChatMessage(id: Random().nextInt(1000000000), userId: userId, aiID: widget.aiPartner.id, text: text, isFromUser: isUser, timestamp: DateTime.now());
    //TODO: send to translation API
    String responseText =  "My name is ${widget.aiPartner.name} -- ${message.text}";
    MessageService().sendMessage(message);
    //Would hypothetically send back an AI generated message to the user
    ChatMessage response = ChatMessage(id: Random().nextInt(1000000000), userId: userId, aiID: widget.aiPartner.id, text: responseText, isFromUser: false, timestamp: DateTime.now());
    MessageService().sendMessage(response);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }


}