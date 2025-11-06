import 'package:flutter/material.dart';
import 'package:langpal_prototype/types/user_notifier.dart';
import 'package:provider/provider.dart';

import '../types/ai_partner.dart';
import '../types/user.dart';
import 'chat_page.dart';

class ConversationsPage extends StatefulWidget {
  final List<AiPartner> aiList;
  const ConversationsPage({super.key, required this.aiList});

  @override
  State<ConversationsPage> createState() => _ConversationState();
}

class _ConversationState extends State<ConversationsPage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    //load data from user state

    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: widget.aiList.map((item) {
            if(widget.aiList.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images\logo_outline.png",
                    width: size.width * 0.4,
                    height: size.width * 0.4,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Looks like you haven't started learning Yet \nGo to Conversations to get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  //debugPrint("Tapped on ${item.name}");
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(aiPartner: item),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item.flag_path) as ImageProvider,
                      fit: BoxFit.fill, // fill the box
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), // dark overlay for text readability
                        BlendMode.darken,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color:  Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        item.language,
                        style: const TextStyle(
                          color:  Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        )
                     // Image(image: AssetImage(item.flag_path) as ImageProvider)
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 248, 233),
    );
  }
}