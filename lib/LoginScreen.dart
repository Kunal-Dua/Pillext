import 'package:flutter/material.dart';
import 'package:pillext/resources/auth_methods.dart';
import 'package:pillext/responsive/mobileScreenLayout.dart';
import 'package:pillext/responsive/responsive_layout_screen.dart';
import 'package:pillext/responsive/webScreenLayout.dart';
import 'package:pillext/signUpScrenn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void logIn() async {
    String res = await AuthMethods().logInUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "Successfully signed in") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )));
    }
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: 46),
            Image.asset("assets/images/logo.png"),
            const SizedBox(height: 26),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Enter email id",
                labelText: "Email Id",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Enter password",
                labelText: "Password",
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: logIn,
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(100, 40),
              ),
              child: const Text("Log In"),
            ),
            //Google Btn
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignUpScreen()));
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(100, 40),
              ),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      )),
    );
  }
}
