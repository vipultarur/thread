import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/services/navigation_service.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final NavigationService navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
        selectedIndex: navigationService.currentIndex.value,
        onDestinationSelected: (value) => navigationService.updateIndex(value),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: const Duration(microseconds: 500),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            label: "Search",
            selectedIcon: Icon(Icons.search),
          ),
          NavigationDestination(
            icon: Icon(Icons.add_outlined),
            label: "Add",
            selectedIcon: Icon(Icons.add),
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            label: "Notify",
            selectedIcon: Icon(Icons.notifications),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: "Profile",
            selectedIcon: Icon(Icons.person),
          ),
        ],
      )),
      body: Obx(
            () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: navigationService.pages()[navigationService.currentIndex.value],
        ),
      ),
    );
  }
}
