import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/profile_controller.dart';
import 'package:thread/widets/image_select.dart';
import '../../services/supabase_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfile> {
  final TextEditingController bioController=TextEditingController(text:"");
  final ProfileController controller = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    if(supabaseService.currentUser.value?.userMetadata?["bio"]!=null)
      bioController.text=supabaseService.currentUser.value?.userMetadata?["bio"];
    super.initState();
  }
  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        actions: [
          Obx(()=>
             TextButton(
              onPressed: () {
                controller.updateProfile(supabaseService.currentUser.value!.id, bioController.text);
              },

              child: controller.loading.value ? const SizedBox(height: 14,width: 14,child: CircularProgressIndicator(),):const Text("Done"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(()=>
               Stack(
                alignment: Alignment.topRight,
                children: [
                  ImageSelect(
                    radius: 80,
                    url: supabaseService.currentUser.value?.userMetadata?["image"] ?? 'assets/images/default_profile_pic.png',
                  ),
                  IconButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    icon: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white60,
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: bioController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Your Bio",
                label: Text("Bio"),
              ),
              onChanged: (value) {
                // Optionally add bio updating logic if required
              },
            ),
          ],
        ),
      ),
    );
  }
}
