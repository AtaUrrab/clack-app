import 'package:get/get.dart';

import '../app/screens/auth/view/auth_screen.dart';
import '../app/screens/auth/view/otp_screen.dart';
import '../app/screens/home/addfriends/view/add_frinds_screen.dart';
import '../app/screens/home/camera/view/camera_screen.dart';
import '../app/screens/home/camera/view/show_clicked_image.dart';
import '../app/screens/home/chats/allcalls/view/all_calls_screen.dart';
import '../app/screens/home/chats/allchats/all_chats_screen.dart';
import '../app/screens/home/chats/allchats/coversation/view/conversation_screen.dart';
import '../app/screens/home/chats/allchats/image/view/image_show_screen.dart';
import '../app/screens/home/chats/allchats/storyview/view/story_view_screen.dart';
import '../app/screens/home/chats/allgroups/view/all_groups_screen.dart';
import '../app/screens/home/chats/chats_main_screen.dart';
import '../app/screens/home/contactedit/view/contact_edit_screen.dart';
import '../app/screens/home/home_screen.dart';
import '../app/screens/home/locater/view/locater_screen.dart';
import '../app/screens/home/notification/view/notification_screen.dart';
import '../app/screens/home/settings/account/view/user_account.dart';
import '../app/screens/home/settings/settngs_screen.dart';
import '../app/screens/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String locater = '/locater';
  static const String chatsMainScreen = '/chatsmainscreen';
  static const String allChatsScreen = '/allchats';
  static const String allGroupsScreen = '/allgroups';
  static const String allCallsScreen = '/allcalls';
  static const String addFriendsScreen = '/addfriends';
  static const String userProfileShowScreen = '/userprofileshow';
  static const String conversation = '/conversation';
  static const String cameraScreen = '/camera';
  static const String showClickedImageScreen = '/showclickedimage';
  static const String storyViewScreen = '/storyViewScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String userAccountScreen = '/userAccountScreen';
  static const String contactEditScreen = '/contactEditScreen';

  List<GetPage> allPagesRoutes = [
    GetPage(
      name: splash,
      page: () => const SplashSCreen(),
    ),
    GetPage(
      name: auth,
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: otp,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: profile,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: locater,
      page: () => const LocaterScreen(),
    ),
    GetPage(
      name: chatsMainScreen,
      page: () => const ChatsMainScreen(),
    ),
    GetPage(
      name: allChatsScreen,
      page: () => const AllChatsScreen(),
    ),
    GetPage(
      name: allGroupsScreen,
      page: () => const AllGroupsScreen(),
    ),
    GetPage(
      name: allCallsScreen,
      page: () => const AllCallsScreen(),
    ),
    GetPage(
      name: addFriendsScreen,
      page: () => const AddFriendsScreen(),
    ),
    GetPage(
      name: userProfileShowScreen,
      page: () => const UserProfileShowScreen(),
    ),
    GetPage(
      name: conversation,
      page: () => const ConversationScreen(),
    ),
    GetPage(
      name: cameraScreen,
      page: () => const CameraScreen(),
    ),
    GetPage(
      name: showClickedImageScreen,
      page: () => const ShowCLickedImageScreen(),
    ),
    GetPage(
      name: storyViewScreen,
      page: () => const StoryViewScreen(),
    ),
    GetPage(
      name: notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: userAccountScreen,
      page: () => const UserAccountScreen(),
    ),
    GetPage(
      name: contactEditScreen,
      page: () => const ContactEditScreen(),
    ),
  ];
}
