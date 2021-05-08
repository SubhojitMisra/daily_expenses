//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addExpenses(String Item, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Activity')
        .doc(Item);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value, 'Time': Timestamp.now()});
        return true;
      }
      /*if (snapshot.data()[Item] == Null) {
        documentReference.set({Item: value});
        return true;
      }*/
      //double newAmount = snapshot.data()[Item] + value;
      transaction.update(documentReference, {'Amount': value});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> totalSum(String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Sum')
        .doc('Add');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      }
      /*if (snapshot.data()[Item] == Null) {
        documentReference.set({Item: value});
        return true;
      }*/
      double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> salary(String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('Add');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      }
      //if (snapshot.data()[Add] == Null) {
      documentReference.set({'Amount': value});
      return true;
    }
        /*double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;*/
        );
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> initialSalary() async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    //var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('Add');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'Amount': 00});
        return true;
      }
      //if (snapshot.data()[Add] == Null) {
      //documentReference.set({'Amount': value});
      return true;
    }
        /*double newAmount = snapshot.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;*/
        );
    return true;
  } catch (e) {
    return false;
  }
}
