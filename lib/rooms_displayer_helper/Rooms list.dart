import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:chat_flutter/rooms_displayer_helper/roomTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomsList extends StatelessWidget {
  late CollectionReference<Room> roomCollection;
  bool isBrowseSelected;
  RoomsList(this.isBrowseSelected)
  {
    roomCollection= getRoomsCollectionWithConverter();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 32, left: 16, right: 24, bottom: 8),
        child: FutureBuilder<QuerySnapshot<Room>>(
          future: roomCollection.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot<Room>> snapshot) {

            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {

              final List<Room> myRoomList = snapshot.data?.docs.map((e) => e.data()).toList() ??[];
              return myRoomList.length == 0 ?
              Center(
                  child: isBrowseSelected? Text("No rooms available", style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.3))):
                      Text("No rooms joined yet" , style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.3)))
              ):
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 21,
                  mainAxisSpacing: 21,
                  childAspectRatio: 0.88,
                ),
                itemBuilder: (buildContext, index){
                  return RoomTile(myRoomList[index],isBrowseSelected);
                },itemCount: myRoomList.length,

              );
            }

            return Center(child :CircularProgressIndicator());
          },
        )
    );
  }
}
