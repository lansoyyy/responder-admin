import 'package:flutter/material.dart';
import 'package:responder_admin/utils/colors.dart';
import 'package:responder_admin/widgets/text_widget.dart';

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
                      onPressed: () {},
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
          Container(
            width: 600,
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
              DataRow(
                cells: [
                  DataCell(
                    TextWidget(
                        text: 'Sample',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white),
                  ),
                  DataCell(
                    TextWidget(
                        text: 'Sample',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white),
                  ),
                  DataCell(
                    TextWidget(
                        text: 'Sample',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white),
                  ),
                  DataCell(
                    TextWidget(
                        text: 'Sample',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white),
                  ),
                  DataCell(
                    TextWidget(
                        text: 'Sample',
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.white),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
