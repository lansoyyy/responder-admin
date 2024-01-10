import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responder_admin/widgets/text_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../login_screen.dart';

class AnalyticsTab extends StatefulWidget {
  const AnalyticsTab({super.key});

  @override
  State<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<AnalyticsTab> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool hasLoaded = false;

  int january = 0;

  int february = 0;

  int march = 0;

  int april = 0;

  int may = 0;

  int june = 0;

  int july = 0;

  int august = 0;

  int september = 0;

  int october = 0;

  int november = 0;

  int december = 0;

  getData() {
    FirebaseFirestore.instance
        .collection('Reports')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        if (doc['month'] == 1) {
          setState(() {
            january++;
          });
        } else if (doc['month'] == 2) {
          setState(() {
            february++;
          });
        } else if (doc['month'] == 3) {
          setState(() {
            march++;
          });
        } else if (doc['month'] == 4) {
          setState(() {
            april++;
          });
        } else if (doc['month'] == 5) {
          setState(() {
            may++;
          });
        } else if (doc['month'] == 6) {
          setState(() {
            june++;
          });
        } else if (doc['month'] == 7) {
          setState(() {
            july++;
          });
        } else if (doc['month'] == 8) {
          setState(() {
            august++;
          });
        } else if (doc['month'] == 9) {
          setState(() {
            september++;
          });
        } else if (doc['month'] == 10) {
          setState(() {
            october++;
          });
        } else if (doc['month'] == 11) {
          setState(() {
            november++;
          });
        } else if (doc['month'] == 12) {
          setState(() {
            december++;
          });
        }
      }
    }).then((value) {
      setState(() {
        hasLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(1, january.toDouble()),
      SalesData(2, february.toDouble()),
      SalesData(3, march.toDouble()),
      SalesData(4, april.toDouble()),
      SalesData(5, may.toDouble()),
      SalesData(6, june.toDouble()),
      SalesData(7, july.toDouble()),
      SalesData(8, august.toDouble()),
      SalesData(9, september.toDouble()),
      SalesData(10, october.toDouble()),
      SalesData(11, november.toDouble()),
      SalesData(12, december.toDouble()),
    ];
    return hasLoaded
        ? Padding(
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
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            print(snapshot.error);
                                            return const Center(
                                                child: Text('Error'));
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            print('waiting');
                                            return const Padding(
                                              padding: EdgeInsets.only(top: 50),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                                          .format(data
                                                              .docs[index]
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
                                          style:
                                              TextStyle(fontFamily: 'QRegular'),
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: SfCartesianChart(
                    // Primary X and Y axes configuration
                    primaryXAxis: CategoryAxis(
                      // Add labels to the X-axis
                      title: AxisTitle(text: 'Months'), // X-axis label
                    ),
                    primaryYAxis: NumericAxis(
                      // Add labels to the Y-axis
                      title:
                          AxisTitle(text: 'Number of Reports'), // Y-axis label
                    ),
                    series: <ChartSeries>[
                      // Renders line chart
                      ColumnSeries<SalesData, int>(
                        dataSource: chartData,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                      ),
                    ],
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
                      return Container(
                        width: 700,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: DataTable(columns: [
                            DataColumn(
                              label: TextWidget(
                                  text: 'Baranggay',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextWidget(
                                  text: 'Name',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextWidget(
                                  text: 'Date',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextWidget(
                                  text: 'Incident',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color: Colors.black),
                            ),
                            DataColumn(
                              label: TextWidget(
                                  text: 'Status',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                  color: Colors.black),
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
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextWidget(
                                        text: data.docs[i]['name'],
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextWidget(
                                        text: DateFormat.yMMMd()
                                            .add_jm()
                                            .format(data.docs[i]['dateTime']
                                                .toDate()),
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextWidget(
                                        text: data.docs[i]['caption'],
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                        color: Colors.grey),
                                  ),
                                  DataCell(
                                    TextWidget(
                                        text: data.docs[i]['status'],
                                        fontSize: 14,
                                        fontFamily: 'Regular',
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                          ]),
                        ),
                      );
                    }),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
