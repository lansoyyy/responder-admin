import 'package:flutter/material.dart';
import 'package:responder_admin/utils/colors.dart';

class AnnouncementTab extends StatelessWidget {
  const AnnouncementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
