import 'dart:io';

import 'package:clack_app/app/utils/appdialogs/show_ok_dialog.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> imagePickerFunc(ImageSource source) async {
  try {
    final XFile? image = await ImagePicker().pickImage(source: source);

    if (image == null) {
      // User canceled the image picking
      return null;
    }

    return File(image.path);
  } catch (e) {
    CallOkDialog.showOSDialog(
        message: "Error picking image. Please try again.");
    return null;
  }
}
