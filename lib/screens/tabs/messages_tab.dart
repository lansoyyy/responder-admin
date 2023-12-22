import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/add_message.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/toast_widget.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final msgController = TextEditingController();
  String msg = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 750,
          height: 700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: 'Chat',
                fontSize: 19,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Message')
                      .orderBy('dateTime')
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

                    final data1 = snapshot.requireData;
                    return SizedBox(
                      height: 350,
                      width: 500,
                      child: ListView.builder(
                        itemCount: data1.docs.length,
                        itemBuilder: (context, index1) {
                          return ListTile(
                            leading: const Icon(
                              Icons.account_circle_outlined,
                            ),
                            title: TextWidget(
                              text: data1.docs[index1]['msg'],
                              fontSize: 18,
                            ),
                            subtitle: TextWidget(
                              text: data1.docs[index1]['name'],
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                    );
                  }),
              TextFormField(
                controller: msgController,
                decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (msgController.text != '') {
                          addMessage('Admin', msgController.text);
                          showToast('Message sent!');
                          msgController.clear();
                        } else {
                          showToast('Please input a message');
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
