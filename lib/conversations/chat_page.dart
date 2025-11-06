import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langpal_prototype/types/ai_partner.dart';
import 'package:path_provider/path_provider.dart';


import '../types/chat_message.dart';
import 'chat_interface.dart';
import 'message_service.dart'; // For simple parsing



class ChatPage extends StatefulWidget{

  final AiPartner aiPartner;

  ChatPage({Key? key, required this.aiPartner}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPage();

}

class _ChatPage extends State<ChatPage>{
  TextEditingController chatInput = TextEditingController();
  bool isLoading = true;
  late StreamSubscription<ChatMessage> _subscription;
  final StreamController<ChatMessage> messageController = StreamController<ChatMessage>.broadcast();

  //ChatBox Data
    final List<ChatMessage> _messages = [
    ChatMessage(
      id: 1,
      userId: "1",
      aiID: "1",
      text: "Hello! How can I help you today?",
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    )
  ];

  @override
  void initState(){
    super.initState();
    _subscription = MessageService().messageStream.listen((message){
      setState((){
        _messages.add(message);
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }
  @override
  void dispose(){
    _subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return (isLoading == true || _messages.isEmpty) ? Scaffold(
        appBar: AppBar(title: Text('Conversation Loading')),
        body: Center(child: CircularProgressIndicator()),
      ): Scaffold(
        appBar: AppBar(
        title: Text(
          widget.aiPartner.name,
          style: GoogleFonts.nunito(
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.5,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 7, 172, 190),
        foregroundColor: Color.fromARGB(255, 42, 42, 42),
      ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 255, 248, 233),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Expanded(
                   child: const SizedBox(height: 8),
                ),
                ChatContainer(messages: _messages),
                const SizedBox(height: 8),
                ChatInput(aiPartner: widget.aiPartner),
                SizedBox(height: height * 0.08,)
            ],
          ),
        ), 
      );
  }

}