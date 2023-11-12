import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReport(reporter, type, img, desc, categ) async {
  final docUser = FirebaseFirestore.instance.collection('Reports').doc();

  final json = {
    'reporter': reporter,
    'type': type,
    'img': img,
    'desc': desc,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'id': docUser.id,
    'categ': categ,
    'uid': FirebaseAuth.instance.currentUser!.uid
  };

  await docUser.set(json);
}
