import 'package:flutter/material.dart';
import 'package:responder_admin/screens/home_screen.dart';
import 'package:responder_admin/widgets/button_widget.dart';
import 'package:responder_admin/widgets/text_widget.dart';
import 'package:responder_admin/widgets/textfield_widget.dart';
import 'package:responder_admin/widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image 1.png',
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: 'BDRRMC Web Responsive App',
              fontSize: 24,
              fontFamily: 'Bold',
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Username',
              controller: usernameController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              isObscure: true,
              showEye: true,
              label: 'Password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              label: 'Login',
              onPressed: () {
                if (usernameController.text == 'admin-username' &&
                    passwordController.text == 'admin-password') {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                } else {
                  showToast('Incorrect admin credentials!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
