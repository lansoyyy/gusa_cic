import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(fname, mname, lname, gender, mobilenumber, address, bloodtype,
    email, password) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'fname': fname,
    'mname': mname,
    'lname': lname,
    'gender': gender,
    'mobilenumber': mobilenumber,
    'address': address,
    'bloodtype': bloodtype,
    'email': email,
    'password': password,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'type': 'User'
  };

  await docUser.set(json);
}
