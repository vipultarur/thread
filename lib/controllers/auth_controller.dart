import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread/controllers/storage_service.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/utils/storage_key.dart';
import '../routes/routes_names.dart';
import '../utils/helper.dart';

class AuthController extends GetxController {
  var registerloading = false.obs;
  var loginloading = false.obs;

  // Register user
  Future<void> register(String name, String email, String password) async {
    try {
      registerloading.value = true;
      final AuthResponse data = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      registerloading.value = false;

      if (data.user != null) {
        // Save the session information
        StorageService.session.write(StorageKey.userSession, data.session?.toJson());
        // Redirect to home screen after successful registration
        Get.offAllNamed(RoutesNames.home);
      }
    } on AuthException catch (error) {
      registerloading.value = false;
      showSnackBar("Error", error.message);
    } catch (error) {
      registerloading.value = false;
      showSnackBar("Error", "Something went wrong. Please try again.");
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      loginloading.value = true;
      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: email, password: password);
      loginloading.value = false;

      if (response.user != null) {
        // Save the session information
        StorageService.session.write(StorageKey.userSession, response.session!.toJson());
        // Redirect to home screen after successful login
        Get.offAllNamed(RoutesNames.home);
      } else {
        showSnackBar("Error", "Invalid email or password.");
      }
    } on AuthException catch (error) {
      loginloading.value = false;
      showSnackBar("Error", error.message);
    } catch (error) {
      loginloading.value = false;
      showSnackBar("Error", "Something went wrong. Please try again.");
    }
  }
}
