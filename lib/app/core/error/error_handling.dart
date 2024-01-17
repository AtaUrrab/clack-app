// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;

// import '../../utils/appdialogs/show_ok_dialog.dart';
// import '../../utils/widgets/custom_circular_progress.dart';

// void httpErrorHandleFunc({
//   required http.Response response,
//   required VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       CustomProgressIndicator().hideProgress();
//       onSuccess();
//       break;
//     case 400:
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: jsonDecode(response.body)['msg']);

//       break;
//     case 500:
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: jsonDecode(response.body)['error']);

//       break;
//     default:
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: jsonDecode(response.body));
//   }
// }
