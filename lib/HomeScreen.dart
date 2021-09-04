import 'package:chat_flutter/creatingGroup/createGroupPage.dart';
import 'package:chat_flutter/rooms_displayer_helper/Rooms%20list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SideMenu.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSeacrhIconPressed = false;
  String searchValue='';

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
            appBar: _isSeacrhIconPressed? PreferredSize(
              preferredSize: Size.fromHeight(132.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12, left: 25, right: 7),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: TextField(
                              onChanged: searchTextChanged,
                              decoration: InputDecoration(
                                hintText: "Search Room Name",
                                hintStyle: TextStyle(color: Color(0x593598DB), fontSize: 14),
                                prefixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      searchValue='';
                                      _isSeacrhIconPressed=false;
                                    });
                                  },
                                  color: Color(0xFF3598DB),
                                  icon: Icon(Icons.close),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                      )
                  )
                ],
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        "My Rooms",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Browse",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
            :PreferredSize(
              preferredSize: Size.fromHeight(132.0),
              child: AppBar(
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
                        "My Rooms",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Browse",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(
                    context,
                    CreateGroup.routeName,
                    arguments: isGroupCreated
                );
              },
              child: Icon(Icons.add),
            ),
            drawer: Drawer(child: SideMenu(),),
            body:
                TabBarView(
                  children: [
                    RoomsList(false, searchValue, isGroupCreated),
                    RoomsList(true, searchValue, isGroupCreated)
                  ],
                ),
            ),
        )
      ],
    );
  }
  isGroupCreated()
  {
    setState(() {

    });
  }

  void searchTextChanged(String text)
  {
    setState(() {
      searchValue = text;
    });
  }
}
