import 'package:flutter/material.dart';
import 'User.dart';

class MythemeData{
  static const primaryColor = Color.fromARGB(255,53,152,219);
  static const white = Colors.white;
}

class AppProvider extends ChangeNotifier{
  User? currentUser ;

  void updateUser(User ? user)
  {
    currentUser = user;
    notifyListeners();
  }



}