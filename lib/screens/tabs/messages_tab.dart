import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                          return Row(
                            mainAxisAlignment:
                                data1.docs[index1]['name'] == 'Admin'
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              data1.docs[index1]['name'] != 'Admin'
                                  ? const Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: CircleAvatar(
                                        minRadius: 15,
                                        maxRadius: 15,
                                        child:
                                            Icon(Icons.account_circle_rounded),
                                      ),
                                    )
                                  : const SizedBox(),
                              Column(
                                crossAxisAlignment:
                                    data1.docs[index1]['name'] == 'Admin'
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0),
                                        bottomLeft: data1.docs[index1]
                                                    ['name'] ==
                                                'Admin'
                                            ? const Radius.circular(20.0)
                                            : const Radius.circular(0.0),
                                        bottomRight: data1.docs[index1]
                                                    ['name'] ==
                                                'Admin'
                                            ? const Radius.circular(0.0)
                                            : const Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Text(
                                      data1.docs[index1]['msg'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontFamily: 'QRegular'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '${DateFormat.jm().format(data1.docs[index1]['dateTime'].toDate())} - ${data1.docs[index1]['name']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.0,
                                          fontFamily: 'QRegular'),
                                    ),
                                  ),
                                ],
                              ),
                              data1.docs[index1]['name'] == 'Admin'
                                  ? const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: CircleAvatar(
                                        minRadius: 15,
                                        maxRadius: 15,
                                        child:
                                            Icon(Icons.account_circle_rounded),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
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
