import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('Salary')
                      .doc('Add')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var document = snapshot.data;
                      return Card(
                        child: Text('Salary: ${document.data()['Amount']}'),
                      );
                    }
                  }),
            )
          ],
        ),
        Row(
          children: [
            //Card();
            Card(
              child: Center(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .collection('Sum')
                      .doc('Add')
                      .snapshots(),
                  //initialData: Text("Current Balance:00"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var document = snapshot.data;
                      return Column(
                        children: [
                          Text("Current balance:${document.data()['Amount']}"),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
