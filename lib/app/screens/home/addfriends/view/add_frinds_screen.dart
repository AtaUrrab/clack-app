import 'package:clack_app/app/utils/res/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/widgets/custom_form_field.dart';
import '../../../../utils/widgets/custom_list_tile.dart';
import '../controller/add_friends_controller.dart';

class AddFriendsScreen extends StatelessWidget {
  const AddFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddFriendsController());
    return GestureDetector(
      onTap: () => controller.focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Add Friends",
                    style: AppTextStyle.poppinsRegular
                        .copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: Get.height * .06),
                CustomFormField(
                  focusNode: controller.focusNode,
                  controller: controller.searchController,
                  hinttext: "your@gmail.com",
                  iconWidget: InkWell(
                    onTap: () => controller.onSearchFunc(),
                    child: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * .04),
                Obx(() {
                  if (controller.searchedUser.value == null) {
                    return const Offstage();
                  } else {
                    return ListTile(
                      title: CustomListTileWidget(
                        imagePath:
                            controller.searchedUser.value!.profilePicture,
                        name: controller.searchedUser.value!.name,
                        email: controller.searchedUser.value!.email,
                        onTap: () => controller.onChatTap(),
                      ),
                    );
                  }
                }),
                SizedBox(height: Get.height * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
