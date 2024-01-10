import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responder_admin/services/add_notif.dart';

Future addAnnouncements(name, desc) async {
  final docUser = FirebaseFirestore.instance.collection('Announcements').doc();

  final json = {
    'name': name,
    'desc': desc,
    'dateTime': DateTime.now(),
    'status': 'Pending',
  };

  addNotif(name, 'Administrator', '', desc, '', 0, 0);

  await docUser.set(json);
}
