import 'package:chat_flutter/HomeScreen.dart';
import 'package:chat_flutter/registration/RegistrationScrenn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context,widget){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            RegistrationScreen.routeName :(context)=>RegistrationScreen(),
            HomeScreen.routeName:(context)=>HomeScreen(),
          },
          initialRoute: RegistrationScreen.routeName,
        );
      },
    );
  }


}