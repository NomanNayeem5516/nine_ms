import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nine_ms/components/common_button.dart';
import 'package:nine_ms/screens/main_page.dart';

import '../../helper/colors_helper.dart';
import '../../helper/dimensn_helper.dart';

import '../../helper/string_helper.dart';
import '../../networkManager/repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      Map<String, dynamic> response = await Repository().login(
        email: email,
        password: password,
      );

      if (response['success'] == true) {
        print('Login successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      } else {
        print('Login failed: ${response['message']}');
      }
    } catch (error) {
      print('Error during login: $error');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.logIn),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: DimensnHelper.dimensn_20,
            left: DimensnHelper.dimensn_20,
            right: DimensnHelper.dimensn_20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Lottie.asset(
                'assets/signin.json',
                height: 200,
                width: 150,
              ),
              const Text(
                'Welcome Again',
              ),
              const Text(
                'Sign in to continue',
              ),
              const SizedBox(
                height: 15,
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
                  : CommonButton(
                      onPress: login,
                      child: const Text('Login'),
                    ),
              SizedBox(height: 20,),
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
      ),
    );
  }
}
