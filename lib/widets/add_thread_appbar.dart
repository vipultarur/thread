import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread/controllers/thread_controller.dart';
import 'package:thread/services/navigation_service.dart';
import 'package:thread/services/supabase_service.dart';

class AddThreadAppbar extends StatelessWidget{
  AddThreadAppbar({super.key});
  final ThreadController controller=Get.find<ThreadController>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color:Color(0xff242424))
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                Get.find<NavigationService>().backToPrePage();
              }, icon: Icon(Icons.close)),
              const SizedBox(width: 10,),
              const Text("New Thread",style: TextStyle(fontSize: 20),),
            ],
          ),
          TextButton(onPressed: (){
            if(controller.content.value.isNotEmpty){
              controller.postStore(Get.find<SupabaseService>().currentUser.value!.id);

            }
          },

            child: controller.loading.value ?
              const SizedBox(height: 16,width: 16,):
              Text("Post",style: TextStyle(fontSize: 15,fontWeight: controller.content.value.isNotEmpty?FontWeight.bold:FontWeight.normal),),)

        ],
      ),
    );

  }
  
}