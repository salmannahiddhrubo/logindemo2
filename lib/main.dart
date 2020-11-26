import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logindemo2/homepage.dart';
//import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

//String finalsEmail;
String Emails;
void main() {
  const String email = 'fredrik.eilertsen@gail.com';
  final bool isValid = EmailValidator.validate(email);

  print('Email is valid? ' + (isValid ? 'yes' : 'no'));
  runApp(MaterialApp(
    home: Nahid(),
  ));
}

class Nahid extends StatefulWidget {
  @override
  _NahidState createState() => _NahidState();
}

class _NahidState extends State<Nahid> {
  var formkey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  String username;
  String password;
  String go;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController email1controller = TextEditingController();
  TextEditingController pass1controller = TextEditingController();

  bool _enabled = true;
  bool newuser;
  bool autovalidate = false;

  void _toggleEnabled() {
    setState(() {
      _enabled = !_enabled;
      go = chechkTextFieldEmpty();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    validdata();

    super.initState();
  }

  Future validdata() async {
    sharedPreferences = await SharedPreferences.getInstance();
    newuser = (sharedPreferences.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode1 = FocusNode();
    final FocusNode focusNode2 = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400],
            ],
          ),
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'My Apps',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Text('Email'),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              labelText: 'username',
                            ),
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Email required';
                              }

                              emailcontroller.text != null;
                            },
                            textInputAction: _enabled
                                ? TextInputAction.next
                                : TextInputAction.done,
                            focusNode: focusNode1,
                            onFieldSubmitted: (term) {
                              focusNode1.unfocus();
                              if (_enabled) {
                                FocusScope.of(context).requestFocus(focusNode2);
                              }
                            },
                            onSaved: (value) {
                              username = value;
                            },
                            autovalidate: true,
                          ),
                          Text('Password'),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              controller: passcontroller,
                              decoration:
                                  InputDecoration(labelText: 'password'),
                              obscureText: true,
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return 'password reuired';
                                }
                                if (value.length < 8) {
                                  return '8 chareccter is available';
                                }
                                passcontroller.text != null;
                              },
                              focusNode: focusNode2,
                              onSaved: (value) {
                                password = value;
                              },
                              enabled: _enabled),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () async {
//                               chechkTextFieldEmpty();
                              if (formkey.currentState.validate())
                                formkey.currentState.validate() != null;

                              if (formkey.currentState.validate() == true) {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                    'email', emailcontroller.text);
                                validateEmail('nahidsalman195@gmail.com');

                                sharedPreferences.setBool('login', false).then(
                                    (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage())));
                                setState(() {
                                  autovalidate = true;
                                });
                              }

                              chechkTextFieldEmpty();

                              print('the form is valid');
                              print(emailcontroller.text);
                              print(passcontroller.text);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            'Forget password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Row(
                              children: [
                                RaisedButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  child: Text(
                                    'Google',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  child: Text(
                                    'Facebook',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleEnabled,
        tooltip: 'Toggle enabled/disabled',
        child: Icon(_enabled ? Icons.stop : Icons.play_arrow),
      ),
    );
  }

  chechkTextFieldEmpty() {
    String text1, text2;
    text1 = emailcontroller.text;
    text2 = passcontroller.text;
    if (text1 == '' || text2 == '') {
      print('the field is empty please fill');
    } else {
      print('All input is filled');
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
