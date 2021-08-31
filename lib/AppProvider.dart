import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_flutter/User.dart' as MyUser;
import 'database/DataBaseHelper.dart';

class MythemeData{
  static const primaryColor = Color.fromARGB(255,53,152,219);
  static const white = Colors.white;
}

class AppProvider extends ChangeNotifier{
  MyUser.User? currentUser ;

  bool checkUser() {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    if(firebaseuser != null){
      getUsersCollectionWithConverter().doc(firebaseuser.uid).get()
          .then((retUser){
            if(retUser.data() != null) {
              currentUser = retUser.data();
            }
      });
      notifyListeners();
    }
    return firebaseuser != null;
  }

  void updateUser(MyUser.User ? user)
  {
    currentUser = user;
    notifyListeners();
  }



}