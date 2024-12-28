
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/thread_controller.dart';
import 'package:thread/widets/add_thread_appbar.dart';
import 'package:thread/widets/image_select.dart';
import '../../controllers/profile_controller.dart';
import '../../services/supabase_service.dart';
import '../../widets/thread_image_appbar.dart';

class AddThread extends StatefulWidget {
  const AddThread({super.key});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ThreadController threadController = Get.put(ThreadController());

  // Ensure ProfileController is registered
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddThreadAppbar(),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final user = supabaseService.currentUser.value;
                    final imageUrl = user?.userMetadata?['image'] ?? '';
                    return ImageSelect(
                      radius: 20,
                      url: imageUrl,
                    );
                  }),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final userName = supabaseService
                                  .currentUser.value?.userMetadata?['name'] ??
                              'Guest';
                          return Text('@$userName');
                        }),
                        TextFormField(
                          autofocus: true,
                          controller: threadController.textEditingController,
                          onChanged: (value) =>
                              threadController.content.value = value,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          maxLines: 10,
                          maxLength: 1000,
                          minLines: 1,
                          decoration: const InputDecoration(
                            hintText: 'Type a thread...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => threadController.pickImages(),
                              child: const Icon(Icons.attach_file),
                            ),
                            Obx(() {
                              final contentLength =
                                  threadController.content.value.length;
                              return Text(
                                '$contentLength/1000',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              );
                            }),
                          ],
                        ),
                        // Image preview
                        Obx(
                          () => Column(
                            children: threadController.images.map((file) {
                            return PreviewImageWidget(
                            file: file,
                            onRemoveImage: threadController.removeImage,
                            );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
