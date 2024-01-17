import 'package:cloud_firestore/cloud_firestore.dart';

Future addNotif(
    name, contactnumber, address, caption, imageURL, lat, long) async {
  final docUser = FirebaseFirestore.instance.collection('Notifs').doc();

  final json = {
    'name': name,
    'address': address,
    'caption': caption,
    'status': 'Crisis',
    'userId': '',
    'contactnumber': contactnumber,
    'imageURL': imageURL,
    'dateTime': DateTime.now(),
    'lat': lat,
    'long': long,
    'responder': ''
  };

  await docUser.set(json);
}
