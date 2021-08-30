import 'package:chat_flutter/AppProvider.dart';
import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:chat_flutter/rooms_displayer_helper/roomTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsList extends StatelessWidget {
  late CollectionReference<Room> roomCollection;
  bool isBrowseSelected;
  RoomsList(this.isBrowseSelected)
  {
    roomCollection= getRoomsCollectionWithConverter();
  }

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
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
              final List<Room> rooms = snapshot.data?.docs.map((e) => e.data()).toList() ??[];
              final List<Room> myRoomList = isBrowseSelected? browseRooms(rooms): myRooms(rooms);
              return rooms.length == 0 ?
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
                    return RoomTile(myRoomList[index]);
                },itemCount: myRoomList.length,

              );
            }

            return Center(child :CircularProgressIndicator());
          },
        )
    );
  }

  bool amIMember(Room room)
  {
    for(int i=0;i<room.members.length;i++)
    {
      if(provider.currentUser!.id==room.members[i].toString())
        return true;
    }
    return false;
  }

  List<Room> browseRooms(List<Room> allReturnedRooms){
    List<Room> browseRoomsList=[];
    for(int i=0;i<allReturnedRooms.length;i++)
    {
      if(!amIMember(allReturnedRooms[i]))
        browseRoomsList.add(allReturnedRooms[i]);
    }
    return browseRoomsList;
  }
  List<Room> myRooms(List<Room> allReturnedRooms){
    List<Room> myRoomsList=[];
    for(int i=0;i<allReturnedRooms.length;i++)
    {
      if(amIMember(allReturnedRooms[i]))
        myRoomsList.add(allReturnedRooms[i]);
    }
    return myRoomsList;
  }
}

