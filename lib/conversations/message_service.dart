import 'dart:async';

import '../types/chat_message.dart';

class MessageService {
  //NOTE: MessageService interactions left undone - end goal was to have them be fed into State managed user.conversations
  static final MessageService _instance = MessageService._internal();
  
  factory MessageService() => _instance;
  
  MessageService._internal();
  
  final StreamController<ChatMessage> _messageController = StreamController<ChatMessage>.broadcast();
  
  Stream<ChatMessage> get messageStream => _messageController.stream;
  List<List<String>> _messages = [];
  void sendMessage(ChatMessage message) {
          if(message.isFromUser == true){
        _messages.add(["user", message.text]);
      }else{
        _messages.add(["chatbot", message.text]);
      }
    _messageController.add(message);
  }

  
  void dispose() {
    _messageController.close();
  }
}