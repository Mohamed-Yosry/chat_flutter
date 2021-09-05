import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppProvider.dart';
import 'chatBody.dart';
import 'joinRoomBody.dart';

class JoinRoom extends StatefulWidget {
  static const String routeName = 'joinRoom';

  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  //int curruntIndex=0;

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    final List roomArgs = ModalRoute.of(context)!.settings.arguments as List;

    changingBodyOfJoinRoom() {
      roomArgs[2]();
      setState(() {
        roomArgs[1]=false;
        //curruntIndex=1;
        //print("aaaaaaaaaaaaaaklklllllllllllll");
      });
    }
    //List joinRoomState=[JoinRoomBody(roomArgs, changingBodyOfJoinRoom),ChatBody(roomArgs)];



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

              PopupMenuButton(
                itemBuilder:(context)=> [
                  PopupMenuItem(
                    child: Text("Leave Room"),
                    value: "w",
                  )
                ],
                child: Icon(Icons.more_vert),
                onSelected: (value) {
                  setState(() {
                    roomArgs[0].members.remove(provider.currentUser!.id);
                    final docref= getRoomsCollectionWithConverter().doc(roomArgs[0].id);
                    docref.update({'members': roomArgs[0].members});
                    roomArgs[2]();
                    Navigator.pop(context);
                  });
                },
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
                ? JoinRoomBody(roomArgs,changingBodyOfJoinRoom)
                : ChatBody(roomArgs)
          ),
        ),
      ),
    );
  }
}
