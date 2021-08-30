import 'package:chat_flutter/AppProvider.dart';
import 'package:chat_flutter/creatingGroup/Room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomTile extends StatelessWidget {
  Room toDisplayRoom;
  bool isMyRoom;
  RoomTile(this.toDisplayRoom, this.isMyRoom);

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return isMyRoom != amIMember() ?
    InkWell(
      onTap: (){
        /// go to description and join room page
        /// Navigator.pushNamed(context, JoinRoom.routeName);
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
            Image(
              image: AssetImage('assets/categories/${toDisplayRoom.category}.png'),
              height: 120,
              fit: BoxFit.fitHeight,
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
    )
    : Container(
      width: 0, height: 0,
    );
  }

  bool amIMember()
  {
    for(int i=0;i<toDisplayRoom.members.length;i++)
      {
        if(provider.currentUser!.id==toDisplayRoom.members[i].toString())
          return true;
      }
    return false;
  }
}
