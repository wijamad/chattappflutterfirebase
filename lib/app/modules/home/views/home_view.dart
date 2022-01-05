import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          title: Text(
            "Chats",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              // child: ClipOval(
              //   child: Material(
              //     color: Colors.red,
              //     // borderRadius: BorderRadius.circular(25),
              //     child: InkWell(
              //       // borderRadius: BorderRadius.circular(25),
              //       // onTap: () => Get.toNamed(Routes.PROFILE),
              //       customBorder: CircleBorder(side: BorderSide.none),
              //       child: Icon(
              //         Icons.person,
              //         size: 30,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              child: IconButton(
                icon: const Icon(Icons.person),
                color: Colors.black,
                splashRadius: 20,
                // tooltip: 'Increase volume by 10',
                onPressed: () => Get.toNamed(Routes.PROFILE),
              ),
            ),
          ]),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.chatsStream(authC.user.value.email!),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.active) {
            var listDocsChats = snapshot1.data!.docs;
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: listDocsChats.length,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller
                      .friendStream(listDocsChats[index]["connection"]),
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.active) {
                      var data = snapshot2.data!.data();
                      return data!["status"] == ""
                          ? ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              onTap: () => controller.goToChatRoom(
                                "${listDocsChats[index].id}",
                                authC.user.value.email!,
                                listDocsChats[index]["connection"],
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black26,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: data["photoUrl"] == "noimage"
                                      ? Image.asset(
                                          "assets/logo/noimage.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "${data["photoUrl"]}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              title: Text(
                                "${data["name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: listDocsChats[index]["total_unread"] ==
                                      0
                                  ? SizedBox()
                                  : Chip(
                                      backgroundColor: Colors.red[900],
                                      label: Text(
                                        "${listDocsChats[index]["total_unread"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            )
                          : ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              onTap: () => controller.goToChatRoom(
                                "${listDocsChats[index].id}",
                                authC.user.value.email!,
                                listDocsChats[index]["connection"],
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black26,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: data["photoUrl"] == "noimage"
                                      ? Image.asset(
                                          "assets/logo/noimage.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "${data["photoUrl"]}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              title: Text(
                                "${data["name"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "${data["status"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: listDocsChats[index]["total_unread"] ==
                                      0
                                  ? SizedBox()
                                  : Chip(
                                      backgroundColor: Colors.red[900],
                                      label: Text(
                                        "${listDocsChats[index]["total_unread"]}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[900],
      ),
    );
  }
}
