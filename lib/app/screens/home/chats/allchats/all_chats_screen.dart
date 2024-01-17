import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/chatroom_model.dart';
import '../../../../utils/progress_indicator/custom_circular_progress.dart';
import '../../../../utils/widgets/empty_message.dart';
import '../../../../utils/widgets/mystory_widget.dart';
import '../../../../utils/widgets/single_chat_widget.dart';
import '../../../../utils/widgets/story_show_widget.dart';
import 'all_chats_controller.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllChatsController());
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * .02),

          // Story Section
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: Get.height * .1,
              child: Row(
                children: [
                  const SizedBox(width: 10),

                  //  My Story Section
                  const MyStoryWidget(),

                  // Other User Story Section
                  ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return StoryShowWidget(
                        imagePath: "",
                        // isStoryWatched: true,
                        onTap: () => controller.storyViewFunc(),
                      );
                    },
                  ),

                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),

          // Chats Section
          StreamBuilder(
            stream: controller.chatRoomStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.size == 0) {
                return const EmptyMessageWidget();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: Get.height / 1.5,
                  child: const NativeProgress(),
                );
              }

              List<ChatRoomModel> chatRoomList =
                  controller.chatListMethod(snapshot);

              return ListView.builder(
                shrinkWrap: true,
                itemCount: chatRoomList.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, i) {
                  return SingleChatWidget(
                    chatRoomModel: chatRoomList[i],
                    onMorePressed: (context) => controller.onMorePressedFunc(),
                    onArchivePressed: (context) =>
                        controller.onArchivePressedFunc(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
