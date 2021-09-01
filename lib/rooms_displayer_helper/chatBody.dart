import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  late List roomArgs;
  String typeMessge="";
  ChatBody(this.roomArgs);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
     child: Column(

      children: [
        Expanded(child: Container()),
   Row(
    children: [


        Expanded(child:TextField(
          onChanged: (newText){
            typeMessge='newText';
    },

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal:4 ,vertical: 4),
            hintText: 'Type a message',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all( Radius.circular(12))
            )
          ),
        )
        ),
        InkWell(
          onTap:(){
            sendMessage();
             },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal:8),
            padding: EdgeInsets.symmetric(horizontal:18 ,vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.blue,
            ),
            child: Row(
              children: [
                Text('Send',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
      ],
    )
      ]


    ),//widget
      );
  }
  void sendMessage(){
    if(typeMessge.isEmpty)return;
  }
}