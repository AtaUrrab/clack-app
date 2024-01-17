import 'package:camera/camera.dart';

import '../models/user_model.dart';

String myIPAddress = "http://192.168.0.218:3000";

class Constant {
  static UserModel? user;
}

bool isDeviceOffline = true;

List<CameraDescription> cameras = [];
