import 'package:daily_expenses/functions.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _userNamecontroller = new TextEditingController();
  TextEditingController _salarycontroller = new TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("PROFILE"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _userNamecontroller,
                    decoration: InputDecoration(
                      hintText: 'UserName',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'this cant be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _salarycontroller,
                    decoration: InputDecoration(
                      hintText: 'Salary',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'this cant be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      salary(_salarycontroller.text);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => TabsScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        'Continue',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
