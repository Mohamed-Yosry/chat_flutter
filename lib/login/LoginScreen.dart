import 'package:chat_flutter/database/DataBaseHelper.dart';
import 'package:chat_flutter/registration/RegistrationScrenn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:chat_flutter/User.dart' as MyUser;

import '../AppProvider.dart';
import '../HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
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
            title: Center(
                child: Text(
              'Login',
              textAlign: TextAlign.center,
            )),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(15, 170, 15, 12),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Welcome back!",
                      style: TextStyle(fontSize: 28),
                    )),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
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
                            )),
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
                  padding: EdgeInsets.fromLTRB(0, 130, 0, 20),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_loginFormKey.currentState?.validate() == true) {
                          loginUser();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Row(children: [
                                Expanded(
                                    child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18),
                                )),
                                Icon(
                                  Icons.arrow_forward,
                                ),
                              ]),
                      )),
                ),
                Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RegistrationScreen.routeName);
                      },
                      child: Text(
                        "or Create My Account",
                        style: TextStyle(fontSize: 15),
                      )),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }

  bool isLoading = false;
  void login() {
    if (_loginFormKey.currentState?.validate() == true) {
      loginUser();
    }
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        showErrorMessage("invalid creditional no user exist with this email");
      } else {
        final db = FirebaseFirestore.instance;
        final userRef = getUsersCollectionWithConverter()
            .doc(userCredential.user!.uid)
            .get()
            .then((retrievedUser) {
          provider.updateUser(retrievedUser.data());
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message ?? "somthing went wrong");
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
