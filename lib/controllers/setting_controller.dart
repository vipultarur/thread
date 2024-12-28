import 'package:get/get.dart';
import 'package:thread/controllers/storage_service.dart';
import 'package:thread/routes/routes_names.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/utils/storage_key.dart';

class SettingController extends GetxController{
  void logout() async{
  //   remove user session
    StorageService.session.remove(StorageKey.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RoutesNames.login);
  }
}