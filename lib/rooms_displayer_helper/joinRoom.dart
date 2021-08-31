import 'package:flutter/material.dart';

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
                ? Column(
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
                      Image(
                        image: AssetImage(
                            'assets/categories/${roomArgs[0].category}.png'),
                        //height: 100,
                        fit: BoxFit.fitHeight,
                      ),
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
                  )
                : Column(
                    children: [
                      Text("data"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
