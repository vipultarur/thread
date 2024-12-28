import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../widets/confirm_dilog.dart';
import 'env.dart';

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black87,
    colorText: Colors.white,
    borderRadius: 8,
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    icon: const Icon(
      Icons.info_outline,
      color: Colors.white,
      size: 28,
    ),
    shouldIconPulse: true,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    animationDuration: const Duration(milliseconds: 300),
    forwardAnimationCurve: Curves.easeInOut,
    reverseAnimationCurve: Curves.easeOut,
  );
}

// Pick image from gallery
Future<File?> pickImageFromGallery() async {
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);

  if (file == null) return null;

  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v4()}.jpg";

  File image = await compressImage(File(file.path), targetPath);

  return image;
}

// Compress image file
Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
  );
  return File(result!.path);
}
//get profile url
String getbukket1url(String path){
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";

}

//conform dilog
void confirmDialog(String title,String text,VoidCallback callback){
  Get.dialog(ConfirmDialog(title: title,text: text, callback: callback,));
}