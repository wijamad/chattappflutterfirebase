import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  final authC = Get.find<AuthController>();
  // final String chat_id = (Get.arguments as Map<String, dynamic>)["chat_id"];
  ChatRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/logo/noimage.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Orang ke x",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "Online",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: false),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: false),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: true),
                ItemChat(isSender: false),
                ItemChat(isSender: true),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      autocorrect: false,
                      controller: controller.chatC,
                      focusNode: controller.focusNode,
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            controller.focusNode.unfocus();
                            controller.isShowEmoji.toggle();
                          },
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red[900],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => (controller.isShowEmoji.isTrue)
                ? Container(
                    height: 325,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        controller.addEmojiToChat(emoji);
                      },
                      onBackspacePressed: () {
                        controller.deleteEmoji();
                      },
                      config: Config(
                        backspaceColor: Color(0xFFB71C1C),
                        columns: 7,
                        emojiSizeMax: 32.0,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: Color(0xFFF2F2F2),
                        indicatorColor: Color(0xFFB71C1C),
                        iconColor: Colors.grey,
                        iconColorSelected: Color(0xFFB71C1C),
                        progressIndicatorColor: Color(0xFFB71C1C),
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: "No Recents",
                        noRecentsStyle: const TextStyle(
                            fontSize: 20, color: Colors.black26),
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ))
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              "coba-",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text("00:00"),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
