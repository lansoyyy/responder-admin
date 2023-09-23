import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responder_admin/utils/colors.dart';
import 'package:responder_admin/widgets/text_widget.dart';

import '../login_screen.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Analytics',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
              const SizedBox(
                width: 800,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Reports')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      print(snapshot.error);
                                      return const Center(child: Text('Error'));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
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
                                      height: 400,
                                      child: ListView.builder(
                                        itemCount: data.docs.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              title: TextWidget(
                                                text:
                                                    '${data.docs[index]['name']} added a report',
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontFamily: 'Bold',
                                              ),
                                              subtitle: TextWidget(
                                                text: data.docs[index]
                                                    ['caption'],
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              trailing: TextWidget(
                                                text: DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(data.docs[index]
                                                            ['dateTime']
                                                        .toDate()),
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ));
                                        },
                                      ),
                                    );
                                  }),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.notifications,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Logout Confirmation',
                                    style: TextStyle(
                                        fontFamily: 'QBold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    'Are you sure you want to Logout?',
                                    style: TextStyle(fontFamily: 'QRegular'),
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.account_circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 600,
            height: 200,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextWidget(
            text: 'Reports',
            fontSize: 18,
            fontFamily: 'Bold',
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Reports').snapshots(),
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
                return Container(
                  width: 700,
                  height: 200,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DataTable(columns: [
                    DataColumn(
                      label: TextWidget(
                          text: 'Baranggay',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.white),
                    ),
                    DataColumn(
                      label: TextWidget(
                          text: 'Name',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.white),
                    ),
                    DataColumn(
                      label: TextWidget(
                          text: 'Date',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.white),
                    ),
                    DataColumn(
                      label: TextWidget(
                          text: 'Incident',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.white),
                    ),
                    DataColumn(
                      label: TextWidget(
                          text: 'Status',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.white),
                    ),
                  ], rows: [
                    for (int i = 0; i < data.docs.length; i++)
                      DataRow(
                        cells: [
                          DataCell(
                            TextWidget(
                                text: data.docs[i]['address'],
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.white),
                          ),
                          DataCell(
                            TextWidget(
                                text: data.docs[i]['name'],
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.white),
                          ),
                          DataCell(
                            TextWidget(
                                text: DateFormat.yMMMd()
                                    .add_jm()
                                    .format(data.docs[i]['dateTime'].toDate()),
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.white),
                          ),
                          DataCell(
                            TextWidget(
                                text: data.docs[i]['caption'],
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.white),
                          ),
                          DataCell(
                            TextWidget(
                                text: data.docs[i]['status'],
                                fontSize: 14,
                                fontFamily: 'Regular',
                                color: Colors.white),
                          ),
                        ],
                      ),
                  ]),
                );
              }),
        ],
      ),
    );
  }
}
