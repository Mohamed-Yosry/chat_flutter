import 'package:chat_flutter/registration/RegistrationScrenn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';
import 'HomeScreen.dart';
import 'login/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context,widget) {
        final provider = Provider.of<AppProvider>(context);
        final isloggedInUser = provider.checkUser();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            RegistrationScreen.routeName :(context)=>RegistrationScreen(),
            HomeScreen.routeName:(context)=>HomeScreen(),
            LoginScreen.routeName:(context)=>LoginScreen(),
          },
          initialRoute: isloggedInUser?
          HomeScreen.routeName:
          LoginScreen.routeName,
        );
      },
    );
  }

}
