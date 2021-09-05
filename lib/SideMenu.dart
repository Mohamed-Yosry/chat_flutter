
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';

class SideMenu extends StatelessWidget{
  List<SideMenuItem> sideMenuList=[
    SideMenuItem(Icons.logout, "Sign out",'login')
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Center(child: Text("Chat App!",style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),)),),
        Expanded(
          child: ListView.builder(itemBuilder: (buildContext,index){
          return SideMenuWidget(sideMenuList[index]);

          },itemCount: sideMenuList.length,),
        )

      ],
    );
  }


}

class SideMenuItem{
  late IconData icon;
  late String title;
  late String page;
  SideMenuItem(this.icon, this.title,this.page);
}

class SideMenuWidget extends StatelessWidget {
  SideMenuItem sideMenuItem;

  SideMenuWidget(this.sideMenuItem);
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: (){
        if(sideMenuItem.title == 'Sign out') {
          FirebaseAuth.instance.signOut();
          provider.currentUser = null;
        }
        Navigator.pushReplacementNamed(context, sideMenuItem.page);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(sideMenuItem.icon),
          )
        ,Text(sideMenuItem.title,style: TextStyle(fontSize: 18,),)
        ]
      ),
    );
  }
}





