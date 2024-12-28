import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread/utils/helper.dart';

import '../services/supabase_service.dart';
import '../utils/env.dart';

class ProfileController extends GetxController{
  var loading =false.obs;
  var uploadpath="";
  Rx<File?>image=Rx<File?>(null);

  // update profile method
  Future<void> updateProfile(String userid,String desc) async {
    try{
      loading.value=true;
      if(image.value !=null && image.value!.existsSync()){
        final String dir="$userid/profile.jpg";
        var path = await SupabaseService.client.storage.from(Env.bucket1).upload(dir, image.value!,fileOptions: const FileOptions(upsert: true));
        uploadpath=path;
      }
      //update profile
      await SupabaseService.client.auth.updateUser(UserAttributes(
        data: {
          "bio":desc,
          "image":uploadpath.isNotEmpty?uploadpath:null
        }
      ));
      loading.value=false;
      Get.back();
      showSnackBar("Success", "Profile updated success");
    }on StorageException catch(error){
      loading.value=false;
      showSnackBar("error", error.message);
    }on AuthException catch(error){
      loading.value=false;
      showSnackBar("error", error.message);

    }catch(error){
      loading.value=false;
      showSnackBar("error","something is wrong");

    }
  }

  //pick image
  void pickImage() async{
    File? file=await pickImageFromGallery();
    if(file != null) image.value=file;
  }
}