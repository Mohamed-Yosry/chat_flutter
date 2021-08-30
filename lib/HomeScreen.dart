
import 'package:chat_flutter/creatingGroup/createGroupPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'creatingGroup/Room.dart';
import 'database/DataBaseHelper.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSeacrhIconPressed = false;
  late CollectionReference<Room> roomCollection;

  _HomeScreenState()
  {
    roomCollection= getRoomsCollectionWithConverter();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Image.asset(
            'assets/TopScreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _isSeacrhIconPressed? AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12, left: 25, right: 7),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Room Name",
                            hintStyle: TextStyle(color: Color(0x593598DB), fontSize: 14),
                            prefixIcon: IconButton(
                              onPressed: (){

                              },
                              color: Color(0xFF3598DB),
                              icon: Icon(Icons.search),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                )
              ],
            )
            :AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: new Text(
                  "Chat App",
                  style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      _isSeacrhIconPressed=true;
                    });
                  },
                  icon: Icon(Icons.search),
                )
              ],

              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text(
                      "Browse",
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "My Rooms",
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, CreateGroup.routeName);
              },
              child: Icon(Icons.add),
            ),
            drawer: Drawer(),
            body:
                TabBarView(
                  children: [
                    Container(
                       child: FutureBuilder<QuerySnapshot<Room>>(
                          future: roomCollection.get(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot<Room>> snapshot) {

                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.connectionState == ConnectionState.done) {
                              final List<Room> myRoomList = snapshot.data?.docs.map((e) => e.data()).toList() ??[];
                              return myRoomList.length == 0 ?  Center(child: Text("No rooms available")):
                               Expanded(
                                 child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 21,
                                      mainAxisSpacing: 21,
                                      childAspectRatio: 0.88,
                                    ),
                                  itemBuilder: (buildContex, index){
                                      return InkWell(
                                        onTap: (){
                                          /// go to description and join room page
                                          /// Navigator.pushNamed(context, JoinRoom.routeName);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Image(
                                                  image: AssetImage('assets/categories/${myRoomList[index].category}.png'),

                                              ),
                                              Text(myRoomList[index].name),
                                            ],
                                          ),
                                        ),
                                      );
                                  },itemCount: myRoomList.length,
                              ),
                               );
                            }

                            return Center(child :CircularProgressIndicator());
                          },
                        )
                    ),
                    Container(),
                  ],
                ),



            ),
        )
      ],
    );
  }
}
