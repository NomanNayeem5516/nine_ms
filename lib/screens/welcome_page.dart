
import 'package:flutter/material.dart';
import 'package:nine_ms/helper/font_helper.dart';
import 'package:nine_ms/screens/authScreens/login_screen.dart';
import 'package:nine_ms/screens/authScreens/registration.dart';

import '../helper/string_helper.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.welCome),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(StringHelper.have,style: TextStyle(fontSize: FontHelper.dimensn_18),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: const Text("Login"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(StringHelper.havenot,style: TextStyle(fontSize: FontHelper.dimensn_18),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignupPage()));
              },
              child: const Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}
