import 'package:cloud_firestore/cloud_firestore.dart';

Future addAnnoucements(desc, img) async {
  final docUser = FirebaseFirestore.instance.collection('Announcements').doc();

  final json = {
    'desc': desc,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'id': docUser.id,
    'img': img
  };

  await docUser.set(json);
}
