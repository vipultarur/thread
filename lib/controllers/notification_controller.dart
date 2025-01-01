
import 'package:get/get.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/utils/helper.dart';
import 'package:thread/views/models/NotificationModel.dart';

class NotificationController extends GetxController{
  RxList<NotificationModel> notifications=RxList<NotificationModel>();
  var loading=false.obs;


  void fetchNotifications(String userId) async{
    try{
      loading.value=true;
      final reponse =await SupabaseService.client.from("notifications").select('''
    id,post_id,notification,created_at,user_id,user:user_id(email,metadata)
    ''').eq("to_user_id", userId).order("id",ascending: false);
    loading.value=false;
    if(reponse.isNotEmpty) {
      notifications.value=[for(var item in reponse) NotificationModel.fromJson(item)];
    }

    }catch(e){
      loading.value=false;
      showSnackBar("error", "somethis went worng");
    }

  }
}