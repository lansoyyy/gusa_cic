import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(fname, mname, lname, gender, mobilenumber, address, bloodtype,
    email, password, profile) async {
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
    'profilePicture': profile == ''
        ? 'https://cdn-icons-png.flaticon.com/256/149/149071.png'
        : profile,
    'type': 'User'
  };

  await docUser.set(json);
}
