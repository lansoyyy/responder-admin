import 'package:flutter/material.dart';
import 'package:responder_admin/screens/tabs/analytics_tab.dart';
import 'package:responder_admin/screens/tabs/announcement_tab.dart';
import 'package:responder_admin/screens/tabs/dashboard_tab.dart';
import 'package:responder_admin/screens/tabs/messages_tab.dart';
import 'package:responder_admin/utils/colors.dart';
import 'package:responder_admin/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dashboard = true;
  bool analytics = false;
  bool announcements = false;
  bool messages = false;
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
                    onTap: () {
                      setState(() {
                        dashboard = true;
                        analytics = false;
                        messages = false;
                        announcements = false;
                      });
                    },
                    leading: Icon(
                      Icons.dashboard,
                      color: dashboard ? Colors.white : Colors.grey,
                    ),
                    title: TextWidget(
                      text: 'Dashboard',
                      fontSize: 18,
                      fontFamily: 'Bold',
                      color: dashboard ? Colors.white : Colors.grey,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        dashboard = false;
                        analytics = true;
                        messages = false;
                        announcements = false;
                      });
                    },
                    leading: Icon(Icons.analytics,
                        color: analytics ? Colors.white : Colors.grey),
                    title: TextWidget(
                        text: 'Analytics',
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: analytics ? Colors.white : Colors.grey),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        dashboard = false;
                        analytics = false;
                        messages = false;
                        announcements = true;
                      });
                    },
                    leading: Icon(Icons.announcement,
                        color: announcements ? Colors.white : Colors.grey),
                    title: TextWidget(
                        text: 'Announcements',
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: announcements ? Colors.white : Colors.grey),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        dashboard = false;
                        analytics = false;
                        messages = true;
                        announcements = false;
                      });
                    },
                    leading: Icon(Icons.message,
                        color: messages ? Colors.white : Colors.grey),
                    title: TextWidget(
                        text: 'Messages',
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: messages ? Colors.white : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          dashboard
              ? const DashboardTab()
              : analytics
                  ? const AnalyticsTab()
                  : announcements
                      ? const AnnouncementTab()
                      : const MessagesTab()
        ],
      ),
    );
  }
}
