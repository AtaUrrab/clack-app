import 'dart:io';

import 'package:camera/camera.dart';
import 'package:clack_app/app/core/models/user_model.dart';
import 'package:clack_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/global_variables.dart';
import '../../../../core/constant/methods/image_picker.dart';
import '../../../../core/models/chatroom_model.dart';

class CameraScreenController extends GetxController {
  CameraController? cameraController;
  Future<void>? cameraValue;
  bool isFrontCamera = true;
  FlashMode flashMode = FlashMode.always;

  ChatRoomModel chatRoomModel = ChatRoomModel.empty();
  UserModel otherUser = UserModel.empty();

  @override
  void onInit() {
    helperfunc();
    getValuesFunc();
    super.onInit();
  }

  getValuesFunc() {
    chatRoomModel = Get.arguments['chatRoomModel'];
    otherUser = Get.arguments['otherUser'];
  }

  helperfunc() async {
    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[0], ResolutionPreset.high);
      cameraValue = cameraController?.initialize();
    } else {
      return;
    }
  }

  // Toggle between front and back cameras
  void toggleCamera() {
    isFrontCamera = !isFrontCamera;
    cameraController = CameraController(
      isFrontCamera == true ? cameras[0] : cameras[1],
      ResolutionPreset.high,
    );
    cameraValue = cameraController?.initialize();
    update();
  }

  // Capture and process the image
  void captureImage() async {
    try {
      final XFile imageFile = await cameraController!.takePicture();

      final image = File(imageFile.path);
      Get.toNamed(
        AppRoutes.showClickedImageScreen,
        arguments: {
          "imagePath": image,
          "chatRoomModel": chatRoomModel,
          'otherUser': otherUser
        },
      );
    } catch (e) {
      debugPrint("Error capturing image: $e");
      return;
    }
  }

  // Toggle between flash modes (auto, always, torch)
  void toggleFlash() {
    switch (flashMode) {
      case FlashMode.auto:
        flashMode = FlashMode.always;
        break;
      case FlashMode.always:
        flashMode = FlashMode.off;
        break;
      case FlashMode.off:
        flashMode = FlashMode.auto;
        break;
      default:
        flashMode = FlashMode.always;
    }
    update();
  }

  // SHow Flash Icon Method
  IconData getFlashIcon(FlashMode flashMode) {
    switch (flashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
        return Icons.flash_off;
      default:
        return Icons.flash_on;
    }
  }

  // Pick Image From gallery
  Future<void> pickImageFunc() async {
    try {
      File? image = await imagePickerFunc(ImageSource.gallery);
      if (image == null) {
        return;
      }
      Get.toNamed(
        AppRoutes.showClickedImageScreen,
        arguments: {
          "imagePath": image,
          "chatRoomModel": chatRoomModel,
          'otherUser': otherUser
        },
      );
    } catch (e) {
      return;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
