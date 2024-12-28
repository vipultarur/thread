import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread/services/navigation_service.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/utils/env.dart';
import 'package:thread/utils/helper.dart';
import 'package:uuid/uuid.dart';

class ThreadController extends GetxController {
  final TextEditingController textEditingController = TextEditingController(text: '');
  final content = ''.obs;
  var loading = false.obs;
  var images = <File>[].obs;

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  // Method to pick images
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var file in pickedFiles) {
        images.add(File(file.path));
      }
    }
  }

  // Method to remove an image
  void removeImage(File file) {
    images.remove(file);
  }

  // Method to store a new post
  void postStore(String userId) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";

      List<String> imgPaths = []; // List to hold image paths

      // Upload images if there are any
      for (var image in images) {
        if (image.existsSync()) {
          final imgPath = await SupabaseService.client.storage
              .from(Env.bucket1)
              .upload("$dir/${image.uri.pathSegments.last}", image);
          imgPaths.add(imgPath); // Add uploaded path to the list
        }
      }

      // Reset the post data
      void resetState() {
        content.value = "";
        textEditingController.text="";
        images.clear(); // Clear the image list
      }

      // Insert the post in the database
      await SupabaseService.client.from("post").insert([
        {
          "user_id": userId,
          "content": content.value,
          "image": imgPaths.isNotEmpty ? imgPaths.join(",") : null
        }
      ]);

      loading.value = false;
      resetState();
      showSnackBar("Success", "Thread added successfully");

      // Reset the tab to the first index
      Get.find<NavigationService>().currentIndex.value = 0;
    } on StorageException catch (e) {
      loading.value = false;
      showSnackBar("Error", e.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }
}
