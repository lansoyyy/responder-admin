import 'package:cloud_firestore/cloud_firestore.dart';

Future addMessage(name, msg) async {
  final docUser = FirebaseFirestore.instance.collection('Message').doc();

  final json = {
    'name': name,
    'msg': msg,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
