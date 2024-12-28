import 'dart:convert';

import 'package:get/get.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/views/models/post_models.dart';

class HomeController extends GetxController{
  var loading=false.obs;
  RxList<PostModel> posts=RxList<PostModel>();
  @override
  void onInit() async{
      await fetchThreads();
      super.onInit();
  }


  Future<void> fetchThreads() async{
      loading.value=true;
      final List<dynamic> response=await SupabaseService.client.from("post").select('''
      id,content,image,created_at,comments_count,like_count,user_id,
      users:user_id(email,metadata)
      ''').order("id",ascending: false);
      loading.value=false;
      if(response.isNotEmpty){
        posts.value=[for(var item in response)PostModel.fromJson(item)];
      }
  }
}