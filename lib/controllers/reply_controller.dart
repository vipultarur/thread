import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController {
  final TextEditingController replyController = TextEditingController();
  var loading = false.obs;

  @override
  void onClose() {
    replyController.dispose(); // Dispose the controller when the screen is closed
    super.onClose();
  }
}
