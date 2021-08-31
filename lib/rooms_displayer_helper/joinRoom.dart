import 'package:flutter/material.dart';

import 'chatBody.dart';
import 'joinRoomBody.dart';

class JoinRoom extends StatelessWidget {
  static const String routeName = 'joinRoom';
  @override
  Widget build(BuildContext context) {
    final List roomArgs = ModalRoute.of(context)!.settings.arguments as List;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.fill,
          ),
          color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(roomArgs[0].name),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 4, offset: Offset(4, 8))
                ]),
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: roomArgs[1]
                ? JoinRoomBody(roomArgs)
                : ChatBody(roomArgs)
          ),
        ),
      ),
    );
  }
}
