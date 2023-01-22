import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List> uplaodImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);

    String id = const Uuid().v1();
    if (isPost) {
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return [downloadUrl, id];
  }

  Future<void> deletePostFromStroage(String postId) async {
    final desertRef =
        storage.ref().child("posts").child(auth.currentUser!.uid).child(postId);
    // Delete the file
    await desertRef.delete();
  }
}
