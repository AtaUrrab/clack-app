import 'package:camera/camera.dart';
import 'package:clack_app/app/utils/res/assets_refer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/camera_controller.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CameraScreenController());

    return GetBuilder<CameraScreenController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              FutureBuilder(
                future: controller.cameraValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                        height: Get.height,
                        child: CameraPreview(controller.cameraController!));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Positioned(
                top: 80,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => controller.toggleCamera(),
                        icon: const Icon(
                          Icons.cameraswitch_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.toggleFlash(),
                        icon: Icon(
                          controller.getFlashIcon(controller.flashMode),
                          size: 25,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                child: SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.pickImageFunc(),
                        icon: ImageIcon(
                          const AssetImage(AssetsRefer.pickGalleryIcon),
                          color: Colors.white,
                          size: Get.height * .04,
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => controller.captureImage(),
                        child: Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white, width: 5.0),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
