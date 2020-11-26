import 'package:flutter/material.dart';
import 'package:logindemo2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import "../../../../../Develop/flutter/packages/flutter/lib/material.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  String obmail;

  initial() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      obmail = sharedPreferences.getString('email');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello $obmail',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            MaterialButton(
              onPressed: () {
                sharedPreferences.setBool('login', true);
                sharedPreferences.setBool('home', true);
                // sharedPreferences.setBool('email', true);
                // sharedPreferences.setBool('password', true);

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Nahid()));
              },
              color: Colors.red,
              child: Text(
                'Return',
              ),
            )
          ],
        ),
      ),
    );
  }
}
