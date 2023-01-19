import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  signUp() {}
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
            Container(
                child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 36),
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      "https://cdn.statusqueen.com/dpimages/thumbnail/Boy_Stylish__Dp_Image-2277.jpg"),
                ),
                Positioned(
                    bottom: -10,
                    left: 94,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {},
                    ))
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter email id",
                labelText: "Email Id",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Username",
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter Bio",
                labelText: "Bio",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter password",
                labelText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: signUp,
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
