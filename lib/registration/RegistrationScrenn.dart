import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = 'register';
  final _registerFormKey = GlobalKey<FormState>();
  String userName = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Image.asset('assets/TopScreen.png',
          fit: BoxFit.fill,
          width: double.infinity,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back,), onPressed: (){},),
            title: Text('create Account'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(key: _registerFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (newValue){
                        userName = newValue;
                      },
                      decoration: InputDecoration(
                        labelText: 'User name',
                        floatingLabelBehavior: FloatingLabelBehavior.auto
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (newValue){
                        email = newValue;
                      },
                      decoration: InputDecoration(
                          labelText: 'E-mail',
                          floatingLabelBehavior: FloatingLabelBehavior.auto
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (newValue){
                        password = newValue;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                ),ElevatedButton(onPressed: ()=>createAccount(), child: Text('Create account'))
              ],
            )
          ),
        ),
      ],
    );
  }
  void createAccount()
  {
    if(_registerFormKey.currentState?.validate() == true){

    }
  }
}
