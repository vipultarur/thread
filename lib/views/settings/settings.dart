import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/profile_controller.dart';
import 'package:thread/controllers/setting_controller.dart';
import 'package:thread/utils/helper.dart';
import 'package:thread/widets/image_select.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final SettingController settingController=Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: false,
      ),
      body:
      ListView(
        children: [
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: Text(
              "Notification",
              style: TextStyle(color: Colors.white),
            ),
            secondary: Icon(Icons.notifications, color: Colors.white),
          ),

          ListTile(
            title: Text(
              "Cookies Policy",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.document_scanner, color: Colors.white),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Contact",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.email, color: Colors.white),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.feedback, color: Colors.white),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.logout, color: Colors.white),
            onTap: () {

              confirmDialog("are you sure ?","You want to logout!",settingController.logout);
            },
          ),
          ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25, // Set the radius to 15
                  backgroundImage: AssetImage('lib/assets/images/1717471597286.jpg'), // Load image
                ),
                SizedBox(width: 10,),
                Text(
                 "Developed By Vipul Tarur",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
