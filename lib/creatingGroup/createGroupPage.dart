import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CreateGroupState();
  }

}

class CreateGroupState extends State<CreateGroup>{
   String dropListValue='movies';
   final List<String> dropDownListItem =['movies', 'sports','music'];

  late String groupName,roomDescription;
  final _addRoomKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.fill,

        ),
        color: Colors.white
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("Chat App"),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(4,8)
                )
              ]
            ),
            margin: EdgeInsets.symmetric(vertical: 40,horizontal: 15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Creating New Room",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
                Image(image: AssetImage("assets/createGroup.png",),),//AssetImage("assets/addRoom.png",),),
                Form(
                  key: _addRoomKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onChanged: (text){
                          groupName=text;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Room Name",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (String? value){
                          if(value==null || value.isEmpty){
                            return 'please enter room name';
                          }
                          return null;
                        },
                      ),


                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          value: dropListValue,
                          items: dropDownListItem.map((name){
                              return DropdownMenuItem(
                                value: name,
                                child: Row(
                                  children: [
                                    Image(image: AssetImage("assets/categories/$name.png"),width: 24,height: 24,),
                                    Text("  $name")
                                  ],
                                ),
                            );}).toList(),
                          onChanged: (value){
                            setState(() {
                              print("$value");
                              dropListValue = value!;
                            });

                          },
                        ),),


                        TextFormField(
                          onChanged: (text){
                            roomDescription=text;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Room Description",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter room description';
                            }
                            return null;
                          },
                        ),


                        ElevatedButton(onPressed: ()=>{
                          if(_addRoomKey.currentState?.validate()==true){
                            addRoom()
                          }
                        }, child: Text("Create"))
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),

    );
  }

  void addRoom(){

  }
}