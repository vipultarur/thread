import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/notification_controller.dart';
import 'package:thread/services/navigation_service.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/widets/image_select.dart';
import 'package:thread/widets/loading.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    controller.fetchNotifications(
      Get.find<SupabaseService>().currentUser.value!.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.find<NavigationService>().backToPrePage(),
          icon: const Icon(Icons.close),
        ),
        title: const Text('Notifications'),
      ),
      body: Obx(
            () => controller.loading.value
            ? const Loading()
            : controller.notifications.isNotEmpty
            ? ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            final userMetadata = notification.user?.metadata;

            return ListTile(
              leading: ImageSelect(
                url: userMetadata?.image ?? '',
              ),
              title: Text(userMetadata?.name ?? 'Unknown User'),
              trailing: Text(notification.createdAt ?? ''),
              subtitle: Text(notification.notification ?? ''),
            );
          },
        )
            : const Center(
          child: Text('No notifications available'),
        ),
      ),
    );
  }
}
