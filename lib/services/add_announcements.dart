import 'package:cloud_firestore/cloud_firestore.dart';

Future addAnnouncements(name, desc) async {
  final docUser = FirebaseFirestore.instance.collection('Announcements').doc();

  final json = {
    'name': name,
    'desc': desc,
    'dateTime': DateTime.now(),
    'status': 'Pending',
  };

  await docUser.set(json);
}
