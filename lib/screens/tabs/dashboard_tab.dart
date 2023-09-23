import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responder_admin/utils/colors.dart';
import 'package:responder_admin/widgets/text_widget.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

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
                text: 'Dashboard',
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
                      onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  fontFamily: 'Bold',
                                  color: Colors.white),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                  text: 'Total Reports',
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
                      .where('status', isEqualTo: 'Pending')
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  fontFamily: 'Bold',
                                  color: Colors.white),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                  text: 'Pending Reports',
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
                      .where('status', isEqualTo: 'Rejected')
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  fontFamily: 'Bold',
                                  color: Colors.white),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                  text: 'Rejected Reports',
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Reports')
                      .where('status', isEqualTo: 'Accepted')
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  text: data.docs.length.toString(),
                                  fontSize: 32,
                                  fontFamily: 'Bold',
                                  color: Colors.white),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                  text: 'Accepted Reports',
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
