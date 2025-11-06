import 'package:flutter/material.dart';
import 'package:langpal_prototype/types/user_notifier.dart';
import 'package:provider/provider.dart';

import '../types/ai_partner.dart';
import '../types/user.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

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
    User user = context.watch<UserNotifier>().user!;
    final ai2 = AiPartner(
      name: "Akira",
      id: "ai_002",
      language: "Japanese",
      flag_path: "images/flags/japan.png",
    );

    final ai3 = AiPartner(
      name: "Johann",
      id: "ai_003",
      language: "Germany",
      flag_path: "images/flags/germany.jpg",
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
            vertical: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image
              CircleAvatar(
                radius: width * 0.18,
                backgroundImage: const AssetImage('assets/profile_placeholder.png'),
              ),
              SizedBox(height: height * 0.03),

              // Editable Name
              GestureDetector(
                onTap: () {
                  // TODO: open name edit dialog
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.edit, size: 18),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // Joined Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Joined:"),
                  Text(user.createdAt.toString()),
                ],
              ),
              SizedBox(height: height * 0.015),

              // Time Learning
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Time Learning:"),
                  Text("0 hrs"),
                ],
              ),
              SizedBox(height: height * 0.015),

              // Editable Languages
              GestureDetector(
                onTap: () {
                  // TODO: open languages edit dialog
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Languages:"),
                    Row(
                      children: [
                        Text(user.languages.toString()),
                        const SizedBox(width: 6),
                        const Icon(Icons.edit, size: 18),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),

              // Settings Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: navigate to settings
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text("Settings"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: height * 0.018),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 248, 233),
    );
  }
}