import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responder_admin/services/add_announcements.dart';
import 'package:responder_admin/widgets/text_widget.dart';

import '../../widgets/textfield_widget.dart';

class AnnouncementTab extends StatefulWidget {
  const AnnouncementTab({super.key});

  @override
  State<AnnouncementTab> createState() => _AnnouncementTabState();
}

class _AnnouncementTabState extends State<AnnouncementTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 600,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Announcements',
                  fontSize: 24,
                  fontFamily: 'Bold',
                ),
                TextButton.icon(
                  onPressed: () {
                    addAnnouncementDialog(context);
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: TextWidget(
                    text: 'Add',
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Announcements')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SizedBox(
                  width: 400,
                  height: 600,
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(
                          Icons.info,
                        ),
                        title: TextWidget(
                          text: data.docs[index]['name'],
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Bold',
                        ),
                        subtitle: TextWidget(
                          text: data.docs[index]['desc'],
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Announcements')
                                .doc(data.docs[index].id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }

  final nameController = TextEditingController();

  final descController = TextEditingController();

  addAnnouncementDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextWidget(
            text: 'Posting Announcement',
            fontSize: 18,
            fontFamily: 'Bold',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  label: 'Name of Announcement', controller: nameController),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                  label: 'Description of Announcement',
                  controller: descController),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'Close',
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () {
                // addAnnouncement('', nameController.text, descController.text);
                addAnnouncements(nameController.text, descController.text);
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'Post',
                fontSize: 14,
              ),
            ),
          ],
        );
      },
    );
  }
}
