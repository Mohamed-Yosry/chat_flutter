import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:chat_flutter/rooms_displayer_helper/joinRoom.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  Room toDisplayRoom;
  bool navigateToBrowse;
  final VoidCallback updateBrowse_myRoom;
  RoomTile(this.toDisplayRoom,this.navigateToBrowse, this.updateBrowse_myRoom);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, JoinRoom.routeName, arguments: [toDisplayRoom, navigateToBrowse,
          updateBrowse_myRoom]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage('assets/categories/${toDisplayRoom.category}.png'),
                //height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 9),
            Text(toDisplayRoom.name),
            SizedBox(height: 7,),
            Text(
                "${toDisplayRoom.members.length} Members",
                style: TextStyle(color: Colors.black.withAlpha(75), fontSize: 12,),
            ),

          ],
        ),
      ),
    );
  }


}
