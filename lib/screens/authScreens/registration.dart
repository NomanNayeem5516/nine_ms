import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nine_ms/components/common_button.dart';
import 'package:nine_ms/screens/main_page.dart';

import '../../helper/string_helper.dart';
import '../../networkManager/repository.dart';



class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;

  Future<void> signup() async {
    setState(() {
      isLoading = true;
    });

    try {
      String email = _emailController.text;
      String password = _passwordController.text;
      String name = _nameController.text;

      Map<String, dynamic> response = await Repository().signup(
        email: email,
        password: password,
        name: name,
      );

      if (response['success'] == true) {
        print('Sign-up successful!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        print('Sign-up failed: ${response['message']}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed: ${response['message']}')),
        );
      }
    } catch (error) {
      print('Error during sign-up: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during sign-up: $error')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.signUp,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Lottie.asset(
              'assets/signupOK.json',
              height: 200,
              width: 150,
            ),
            const Text(
              StringHelper.welcomeAgain,

            ),
            const Text(
              StringHelper.signUpToContinue,

            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: StringHelper.name,
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: StringHelper.email,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: StringHelper.password,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : CommonButton(
                    onPress: signup,
                    child: const Text(StringHelper.signUp,),
                  ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: const Text("Direct Home"))
          ],
        ),
      ),
    );
  }
}
