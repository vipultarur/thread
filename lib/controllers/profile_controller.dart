import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread/utils/helper.dart';
import 'package:thread/views/models/ReplyModel.dart';
import 'package:thread/views/models/post_models.dart';

import '../services/supabase_service.dart';
import '../utils/env.dart';

class ProfileController extends GetxController{
  var loading =false.obs;
  var uploadpath="";
  var postloading=false.obs;
  var repliesloading=false.obs;

  RxList<ReplyModel> reply=RxList<ReplyModel>();
  RxList<PostModel> posts=RxList<PostModel>();
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

  //   fatch user post
  Future<void> fetchUserThreads(userId)async{
    try{
      postloading.value=true;
      final List<dynamic> response=await SupabaseService.client.from("post").select('''
      id,content,image,created_at,comments_count,like_count,user_id,
      users:user_id(email,metadata)
      ''').eq("user_id",userId).order("id",ascending: false);
      // print("thread: ${jsonEncode(response)}");

      postloading.value=false;
      if(response.isNotEmpty){
        posts.value=[for(var item in response)PostModel.fromJson(item)];
      }
      postloading.value=false;

    }catch(e){
      postloading.value=false;
      showSnackBar("error", "Something want worng");

    }


  }
  void fetchRepliyes(String userid) async {
    try {
      repliesloading.value = true;

      final List<dynamic> response = await SupabaseService.client
          .from("comments")
          .select('''
          user_id, post_id, reply, created_at,
          user:user_id(email, metadata)
        ''')
          .eq("user_id", userid)
          .order("created_at", ascending: false);

      repliesloading.value = false;

      if (response.isNotEmpty) {
        reply.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      repliesloading.value = false;
      showSnackBar("error", "Something went wrong");
    }
  }


}
