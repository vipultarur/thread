import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread/controllers/home_controller.dart';
import 'package:thread/widets/loading.dart';
import '../../widets/onepost_card.dart';
import '../models/post_models.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});
  final HomeController controller=Get.put(HomeController());
  RxList<PostModel> posts=RxList<PostModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
            title:  Image.asset("lib/assets/images/logo.png",width: 40,height: 40,),
      ),
      backgroundColor: Colors.black,
      body:
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child:
              Obx(()=>
              controller.loading.value?const Loading():ListView.
              builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>
                    PostCard(post: controller.posts[index]),itemCount:controller.posts.length,)
              ),
            )
          ],
        )
      ,
    );
  }
}

