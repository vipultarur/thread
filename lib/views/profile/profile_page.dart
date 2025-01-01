import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/profile_controller.dart';
import 'package:thread/routes/routes_names.dart';
import 'package:thread/services/supabase_service.dart';
import 'package:thread/widets/comment_card.dart';
import 'package:thread/widets/image_select.dart';
import 'package:thread/widets/loading.dart';

import '../../widets/onepost_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    if(supabaseService.currentUser.value?.id!=null){
      controller.fetchRepliyes(supabaseService.currentUser.value!.id);
      controller.fetchUserThreads(supabaseService.currentUser.value!.id);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RoutesNames.settings);

            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body:
      DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                pinned: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supabaseService.currentUser.value?.userMetadata?["name"] ?? "No Name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  supabaseService.currentUser.value?.userMetadata?["bio"] ?? "No Bio",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "theads.net",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => ImageSelect(
                              radius: 50,
                              url: supabaseService.currentUser.value?.userMetadata?["image"] ?? 'assets/images/default_profile_pic.png',
                            )),
                          ],
                        )),

                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.toNamed(RoutesNames.editprofile),
                                child: const Text("Edit Profile"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add logic for viewing profile
                                },
                                child: const Text("View Profile"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Threads"),
                      Tab(text: "Replies"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body:
          TabBarView(
            children: [
              Obx(() => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    if (controller.postloading.value)
                      const Loading()
                    else if (controller.posts.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) => PostCard(
                          post: controller.posts[index],
                        ),
                      )
                    else
                      const Center(
                        child: Text("No Post found"),
                      )
                  ],
                ),
              )),
              Obx(() => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    if (controller.repliesloading.value)
                      const Loading()
                    else if (controller.reply.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.reply.length,
                        itemBuilder: (context, index) {
                          final replyItem = controller.reply[index];
                          return CommentCard(reply: replyItem);
                        },
                      )
                    else
                      const Center(
                        child: Text("No reply found!"),
                      ),
                  ],
                ),
              )),
            ],
          ),

        ),
      ),
    );
  }
}

// Sliver Persistent Header Delegate
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
