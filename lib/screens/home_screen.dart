import 'package:flutter/material.dart';
import 'package:responder_admin/utils/colors.dart';
import 'package:responder_admin/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 250,
            color: primary,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  TextWidget(
                    text: 'BDRRMC Web Responsive App',
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    title: TextWidget(
                      text: 'Dashboard',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.analytics,
                      color: Colors.white,
                    ),
                    title: TextWidget(
                      text: 'Analytics',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.announcement,
                      color: Colors.white,
                    ),
                    title: TextWidget(
                      text: 'Announcements',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    title: TextWidget(
                      text: 'Messages',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
