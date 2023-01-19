import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? imagefile = await imagePicker.pickImage(source: source);
  return await imagefile?.readAsBytes();
}
