import 'package:flutter/material.dart';

class JoinRoomBody extends StatelessWidget {
  late List roomArgs;
  JoinRoomBody(this.roomArgs);
  @override
  Widget build(BuildContext context) {
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
            onPressed: (){

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


