import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:chat_flutter/login/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:chat_flutter/User.dart' as MyUser;

import '../AppProvider.dart';
import '../HomeScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  String userName = '';

  String email = '';

  String password = '';

  bool isPasswordHidden = true;

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Image.asset(
            'assets/TopScreen.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(child: Text('Create Account')),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(15, 200, 15, 12),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (newValue) {
                          userName = newValue;
                        },
                        decoration: InputDecoration(
                          labelText: 'User name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        onChanged: (newValue) {
                          email = newValue;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            fontSize: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: isPasswordHidden ? true : false,
                        onChanged: (newValue) {
                          password = newValue;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () {
                              isPasswordHidden = !isPasswordHidden;
                              setState(() {});
                            },
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            fontSize: 12,
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          //else if(!isValidPassword(value)) {
                          //}
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 20),
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            createAccount();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                            child: isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Row(children: [
                                    Expanded(
                                        child: Text("create account",
                                            style: TextStyle(fontSize: 18))),
                                    Icon(
                                      Icons.arrow_forward,
                                    ),
                                  ]),
                          )
                  ),
                ),
                Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text("Already have Account!")),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }

  final db = FirebaseFirestore.instance;
  bool isLoading = false;
  void createAccount() {
    if (_registerFormKey.currentState?.validate() == true) {
      registerUser();
    }
  }

  final auth = FirebaseAuth.instance;
  void registerUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        //UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save in database
      final userCollectionRef = getUsersCollectionWithConverter();
      final user = MyUser.User(
          id: userCredential.user!.uid, userName: userName, email: email);
      userCollectionRef.doc(user.id).set(user).then((value) {
        provider.updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });

      showErrorMessage("user registered succesful");
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message ?? "somthing went wrong");
      /*if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }*/
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}
