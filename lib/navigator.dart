import 'package:flutter/material.dart';
import 'package:langpal_prototype/conversations/conversations.dart';
import 'package:langpal_prototype/main.dart';
import 'package:langpal_prototype/profile/profile.dart';

class CustomNav extends StatelessWidget{
  final GlobalKey<NavigatorState> navKey;
  final String tab;
  const CustomNav({super.key, required this.navKey, required this.tab});
  
  @override
  Widget build(BuildContext context) {
    Widget child = MyHomePage();
    if(tab == "Conversations")
      child = ConversationsPage();
    else if(tab == "Home")
      child = MyHomePage();
    else if(tab == "Profile")
      child = Profile();

    return Navigator(
      key: navKey,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}