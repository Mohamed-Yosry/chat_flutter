import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppProvider.dart';

class JoinRoomBody extends StatelessWidget {
  late List roomArgs;
  final VoidCallback changingBodyOfJoinRoom;
  JoinRoomBody(this.roomArgs,this.changingBodyOfJoinRoom);

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hello, Welcome to our chat room",
          style: TextStyle(fontSize: 14,),
          textAlign: TextAlign.center,
        ),
        Text(
          "Join ${roomArgs[0].name}!",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,

        ),
        SizedBox(height: 26,),
        /*Expanded(
                        child:*/ Container(
          padding: EdgeInsets.only(left: 40,right:40),
          child: Image(
            image: AssetImage(
                'assets/categories/${roomArgs[0].category}.png'),
            fit: BoxFit.fitHeight,
            width: double.infinity,

          ),
        ),
        //),
        SizedBox(height: 31,),
        Text(
          roomArgs[0].description,
          style: TextStyle(
              color: Color(0xFF7F7F7F), fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 35),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                )
            )),
            onPressed: ()async{
              print("${roomArgs[0].members[0]}");
              roomArgs[0].members.add(provider.currentUser!.id);
              final docref= getRoomsCollectionWithConverter().doc(roomArgs[0].id);
              await docref.update({'members': roomArgs[0].members});

              changingBodyOfJoinRoom();


            },
            child: Text(
              "Join",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}


