import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/views/home/home_page.dart';
import 'package:thread/views/notification/notifications.dart';
import 'package:thread/views/profile/profile_page.dart';
import 'package:thread/views/threads/add_thread.dart';

import '../views/search/searchpage.dart';

class NavigationService extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  // Pages
  List<Widget> pages() {
    return [
       HomePage(),
      const SearchPage(),
       AddThread(),
      const Notifications(),
      const ProfilePage(),
    ];
  }

  // Update index
  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  //back to prev page
  void backToPrePage(){
    currentIndex.value=previousIndex.value;
  }
}

