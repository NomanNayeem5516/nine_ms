import 'package:flutter/material.dart';

import '../../networkManager/repository.dart';
import '../home_page.dart';
// Import the HomePage class

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
          MaterialPageRoute(builder: (context) => const HomePage()),
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
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: signup,
                    child: const Text('Sign Up'),
                  ),
          ],
        ),
      ),
    );
  }
}
