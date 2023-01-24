import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillext/Screens/feed_screen.dart';
import 'package:pillext/models/user.dart' as model;
import 'package:pillext/providers/user_provider.dart';
import 'package:pillext/resources/firestore_methods.dart';
import 'package:pillext/resources/storage_methods.dart';
import 'package:pillext/utils/image_pick.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    TextEditingController _usernameController = TextEditingController()
      ..text = user.username;
    TextEditingController _bioController = TextEditingController()
      ..text = user.bio;
    ;
    TextEditingController _passwordController = TextEditingController();
    String imageUrl = user.photoUrl;

    @override
    void dispose() {
      super.dispose();
      _usernameController.dispose();
      _bioController.dispose();
      _passwordController.dispose();
    }

    void selectImage() async {
      Uint8List im = await pickImage(ImageSource.gallery);

      List arr =
          await StorageMethods().uplaodImageToStorage("profilePics", im, false);
      String photoUrl = arr[0];
      setState(() {
        imageUrl = photoUrl;
      });

      FireStoreMethods().updatePhotoUrl(uid: user.uid, url: photoUrl);
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Enter data to change "),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 46),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 94,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        onPressed: () {
                          selectImage();
                        },
                      ))
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  selectImage();
                  const snackBar = SnackBar(
                    content: Text('Profile Photo Updated!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const FeedScreen()));
                },
                icon: Icon(Icons.photo),
                label: Text("Update photo"),
              ),
              SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: "Change username ",
                    labelText: "Change username",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  FireStoreMethods().editUsername(
                      uid: user.uid, text: _usernameController.text);
                  const snackBar = SnackBar(
                    content: Text('Username Updated!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(Icons.verified_user),
                label: const Text("Username"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    hintText: "bio",
                    labelText: "Change bio",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  const snackBar = SnackBar(
                    content: Text('Bio Updated!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  FireStoreMethods()
                      .editBio(uid: user.uid, text: _bioController.text);
                },
                icon: const Icon(Icons.biotech),
                label: const Text("Bio"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "password ",
                    labelText: "Change password",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('Password Updated!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: Icon(Icons.password),
                  label: Text("Password")),
            ],
          ),
        ),
      ),
    );
  }
}
