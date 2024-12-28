import 'package:get/get.dart';
import 'package:thread/home.dart';
import 'package:thread/routes/routes_names.dart';
import 'package:thread/views/profile/edit_profile.dart';
import 'package:thread/views/profile/profile_page.dart';
import 'package:thread/views/replies/add_reply.dart';
import 'package:thread/views/settings/settings.dart';

import '../views/auth/login.dart';
import '../views/auth/register.dart';

class Routes{
  static final pages=[
    GetPage(name: RoutesNames.home, page: () =>Home()),
    GetPage(name: RoutesNames.login, page: () =>const Login(),transition: Transition.fade),
    GetPage(name: RoutesNames.register, page: () =>const Register(),transition: Transition.fadeIn),
    GetPage(name: RoutesNames.editprofile, page: () => const EditProfile(),transition: Transition.leftToRight),
    GetPage(name: RoutesNames.profilepage, page: () => const ProfilePage(),transition: Transition.rightToLeft),
    GetPage(name: RoutesNames.settings, page: () => Setting(),transition: Transition.rightToLeft),
    GetPage(name: RoutesNames.addreply, page: () => AddReply(),transition: Transition.downToUp),

  ];
}