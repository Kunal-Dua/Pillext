import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillext/resources/auth_methods.dart';
import 'package:pillext/utils/image_pick.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _passwordController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
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
            Container(
                child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 36),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 94,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: selectImage,
                    ))
              ],
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Enter email id",
                labelText: "Email Id",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: "Enter Username",
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                hintText: "Enter Bio",
                labelText: "Bio",
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
            const SizedBox(height: 22),
            InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    bio: _bioController.text,
                    username: _usernameController.text,
                  );
                  print(res);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: Colors.indigo,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
