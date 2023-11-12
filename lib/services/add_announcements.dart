import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addAnnoucements(desc) async {
  final docUser = FirebaseFirestore.instance.collection('Announcements').doc();

  final json = {
    'desc': desc,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'id': docUser.id,
  };

  await docUser.set(json);
}
