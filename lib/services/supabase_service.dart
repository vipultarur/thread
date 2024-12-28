import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread/utils/env.dart';

class SupabaseService extends GetxService{
  Rx<User?>currentUser=Rx<User?>(null);
  @override
  void onInit() async{
    await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
    currentUser.value=client.auth.currentUser;
    listenAuthChanges();
    super.onInit();
  }
  static final SupabaseClient client =Supabase.instance.client;

  // listen auth changes
  void listenAuthChanges() {
    client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;

      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.userUpdated ||
          event == AuthChangeEvent.tokenRefreshed) {
        currentUser.value = data.session?.user;
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null; // User logged out
      }
    });
  }
}