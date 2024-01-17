// import 'dart:convert';

// import 'package:clack_app/app/utils/appdialogs/show_ok_dialog.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../routes/app_routes.dart';
// import '../../utils/widgets/custom_circular_progress.dart';
// import '../constant/global_variables.dart';
// import '../controllers/admin_base_controller.dart';
// import '../error/error_handling.dart';
// import '../models/user_model.dart';

// class AuthService {
//   //

//   // signup user
//   void signUpUser({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       CustomProgressIndicator().showProgress();
//       UserModel userModel = UserModel(
//         userId: "",
//         createdAt: DateTime.now(),
//         name: name,
//         userName: "",
//         userBio: "",
//         email: email,
//         password: password,
//         token: "",
//         isOnline: false,
//         profilePicture: "",
//         isVerifiedAccount: false,
//       );

//       http.Response res = await http.post(
//         Uri.parse("$myIPAddress/api/signup"),
//         body: userModel.toJson(),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//       );

//       httpErrorHandleFunc(
//         response: res,
//         onSuccess: () {
//           // Request OTP
//           requestOTPForSignUp(name: name, email: email, password: password);
//         },
//       );
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

//   // signin user
//   void signInUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       CustomProgressIndicator().showProgress();
//       http.Response res = await http.post(
//         Uri.parse("$myIPAddress/api/signin"),
//         body: jsonEncode({
//           "email": email,
//           "password": password,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//       );
//       httpErrorHandleFunc(
//         response: res,
//         onSuccess: () async {
//           SharedPreferences preferences = await SharedPreferences.getInstance();
//           AdminBaseController.userData.value = UserModel.fromJson(res.body);
//           await preferences.setString(
//             'x-auth-token',
//             jsonDecode(res.body)['token'],
//           );
//           CustomProgressIndicator().hideProgress();
//           Get.offAllNamed(AppRoutes.home);
//         },
//       );
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

//   // Set user data
//   void getUserData() async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       String? token = preferences.getString('x-auth-token');

//       // If there's no token, or the token is empty, go to AuthScreen
//       if (token == null || token.isEmpty) {
//         awaitFunc(); // Go to AuthScreen
//         return;
//       }

//       final tokenRes = await http.post(
//         Uri.parse("$myIPAddress/isTokenValid"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token,
//         },
//       );

//       final response = jsonDecode(tokenRes.body);
//       if (response == true) {
//         // User is logged in, get user data
//         http.Response userRes = await http.get(
//           Uri.parse("$myIPAddress/"),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': token,
//           },
//         );

//         AdminBaseController.userData.value = UserModel.fromJson(userRes.body);

//         // Check if user data has a token
//         if (AdminBaseController.userData.value.token.isNotEmpty) {
//           CustomProgressIndicator().hideProgress();
//           Get.offAllNamed(AppRoutes.home);
//         } else {
//           CustomProgressIndicator().hideProgress();
//           awaitFunc();
//         }
//       } else {
//         CustomProgressIndicator().hideProgress();
//         awaitFunc();
//       }
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

//   // await function
//   void awaitFunc() async {
//     await Future.delayed(const Duration(seconds: 3));
//     Get.offAllNamed(AppRoutes.auth);
//   }

//   // Logout user
//   void signOutUser() async {
//     try {
//       CustomProgressIndicator().showProgress();

//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       String? token = preferences.getString('x-auth-token');

//       if (token != null) {
//         http.Response res = await http.post(
//           Uri.parse("$myIPAddress/api/logout"),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': token,
//           },
//         );

//         httpErrorHandleFunc(
//           response: res,
//           onSuccess: () {
//             // Clear locally stored token
//             preferences.setString('x-auth-token', '');
//             CustomProgressIndicator().hideProgress();
//             Get.offAllNamed(AppRoutes.auth);
//           },
//         );
//       } else {
//         CustomProgressIndicator().hideProgress();
//         CallOkDialog.showOSDialog(message: "User not logged in");
//       }
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

//   // Request OTP for signup
//   void requestOTPForSignUp({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       CustomProgressIndicator().showProgress();

//       http.Response res = await http.post(
//         Uri.parse("$myIPAddress/api/requestOTP"),
//         body: jsonEncode({
//           "name": name,
//           "email": email,
//           "password": password,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       httpErrorHandleFunc(
//         response: res,
//         onSuccess: () {
//           CustomProgressIndicator().hideProgress();
//           CallOkDialog.showOSDialog(
//             message:
//                 "Congratulations Your Account has been created and OTP has been sent to your email address",
//             onTapOk: () {
//               // Navigate to OTP verification screen
//               CustomProgressIndicator().hideProgress();
//               Get.offAllNamed(AppRoutes.otp, arguments: {"email": email});
//             },
//           );
//         },
//       );
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

// // Function to resend OTP
//   void resendOTP({required String email}) async {
//     try {
//       CustomProgressIndicator().showProgress();

//       http.Response res = await http.post(
//         Uri.parse("$myIPAddress/api/resendOTP"),
//         body: jsonEncode({
//           "email": email,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       httpErrorHandleFunc(
//         response: res,
//         onSuccess: () {
//           CustomProgressIndicator().hideProgress();
//           CallOkDialog.showOSDialog(
//             message: "New OTP has been sent to your email address",
//             onTapOk: () {
//               Get.back();
//             },
//           );
//         },
//       );
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }

//   // Verify OTP
//   void verifyOTP({
//     required String email,
//     required String enteredOTP,
//   }) async {
//     try {
//       CustomProgressIndicator().showProgress();

//       http.Response res = await http.post(
//         Uri.parse("$myIPAddress/api/verifyOTP"),
//         body: jsonEncode({
//           "email": email,
//           "otp": enteredOTP,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       httpErrorHandleFunc(
//         response: res,
//         onSuccess: () async {
//           SharedPreferences preferences = await SharedPreferences.getInstance();
//           AdminBaseController.userData.value = UserModel.fromJson(res.body);
//           await preferences.setString(
//             'x-auth-token',
//             jsonDecode(res.body)['token'],
//           );

//           await Future.delayed(const Duration(milliseconds: 500));
//           CustomProgressIndicator().hideProgress();
//           Get.offAllNamed(AppRoutes.home);
//         },
//       );
//     } catch (e) {
//       CustomProgressIndicator().hideProgress();
//       CallOkDialog.showOSDialog(message: e.toString());
//     }
//   }
// }
