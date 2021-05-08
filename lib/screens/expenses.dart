import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_expenses/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  void showdialogbox(bool isUpdate, DocumentSnapshot ds) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String item;
    int amount;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text('Update Task') : Text("ADD TASK"),
            content: Form(
              key: formKey,
              autovalidate: true,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _itemController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        item = val;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _amountController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'This cant be empty';
                        } else {
                          return null;
                        }
                      },
                      /*onChanged: (val) {
                        amount = val as int;
                      }*/
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () async {
                  await addExpenses(
                      _itemController.text, _amountController.text);
                  await totalSum(_amountController.text);
                  Navigator.pop(context);
                },
                child: Text('ADD'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection('Activity')
                .orderBy('Time')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //var doc = snapshot.data.docs;
              //print(snapshot.data.docs.length.toString());
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Card(
                    elevation: 4.0,
                    child: ListTile(
                      leading: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.lightGreen,
                      ),
                      title: Text(document.id),
                      trailing: SizedBox(
                          width: 120,
                          child: Text("${document.data()['Amount']}")),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showdialogbox(false, null),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
