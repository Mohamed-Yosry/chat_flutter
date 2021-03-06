import 'package:chat_flutter/AppProvider.dart';
import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:chat_flutter/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatefulWidget {
  late List roomArgs;

  ChatBody(this.roomArgs);

  @override
  _ChatBodyState createState() => _ChatBodyState(roomArgs);
}

class _ChatBodyState extends State<ChatBody> {
  late List roomArgs;

  String typeMessge="";
  late TextEditingController messageController;
  late CollectionReference<Message>messageRef;

  _ChatBodyState(this.roomArgs);

    @override
    void initState(){
      super.initState();
      messageController= TextEditingController(text :typeMessge);
    }

    late AppProvider provider;

  @override
  Widget build(BuildContext context) {

    messageRef= getMessageCollectionWithConverter(roomArgs[0].id);
    final Stream<QuerySnapshot<Message>> messagesStream=messageRef.orderBy('time')
    .snapshots();

    provider= Provider.of<AppProvider>(context);



    return Container(
      padding: EdgeInsets.all(8),
     child: Column(
      children: [
        Expanded(child:

        StreamBuilder<QuerySnapshot<Message>>(

        stream:messagesStream ,
        builder:  (BuildContext buildContext,AsyncSnapshot<QuerySnapshot<Message>>snapShot){
          if(snapShot.hasError){
            return Text(snapShot.error.toString());

          }
          else if(snapShot.hasData){

            return ListView.builder(itemBuilder: (buildContext,index){
              return ListTile(
                title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Container(

                          child: Text(

                              snapShot.data!.docs[index].data().senderId== provider.currentUser!.id? "":snapShot.data!.docs[index].data().senderName,
                              style: TextStyle(fontSize: 12)

                          ),
                        ),
                    Align(
                      alignment: (snapShot.data!.docs[index].data().senderId== provider.currentUser!.id?Alignment.topRight:Alignment.topLeft),

                      child: Container(
                        decoration: BoxDecoration(
                          color: snapShot.data!.docs[index].data().senderId== provider.currentUser!.id?Color.fromRGBO(53, 152, 219,1):Color.fromRGBO(248, 248, 248,1),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft:snapShot.data!.docs[index].data().senderId== provider.currentUser!.id?Radius.circular(40):Radius.circular(0),
                            topLeft: Radius.circular(40),
                            bottomRight:snapShot.data!.docs[index].data().senderId== provider.currentUser!.id?Radius.circular(0):Radius.circular(40),

                          ),
                        ),
                        padding:EdgeInsets.all(15) ,
                          child: Text(snapShot.data?.docs[index]
                          .data().content??" "),
                        ),
                      ),
                    ],
                ),

              );

              },
              itemCount: snapShot.data?.size??0,
             );
          }

            return Center(child: CircularProgressIndicator(),);

        },


        )

        ),
   Row(
    children: [


        Expanded(child:TextField(
          controller: messageController,
          onChanged: (newText){
            typeMessge=newText;
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

    final newMessageObj =messageRef.doc();
    final message= Message(id: newMessageObj.id,
        content: typeMessge,
        time: DateTime.now().toLocal().millisecondsSinceEpoch ,
        senderName: provider.currentUser?.userName??" ",
        senderId:   provider.currentUser?.id??"",

    );
    newMessageObj.set(message).then((value){
      setState(() {
      messageController.clear();
      });

    });
  }
}

