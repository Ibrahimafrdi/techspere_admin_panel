import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';

class NavigationController extends ChangeNotifier {
  int selectedScreenIndex = 0;

  bool isShowSubScreen = false;
  bool isShowScreen = true;
  bool isClickedProfile = false;
  bool isEditNameTextField = false;
  bool isHoverProfileScreen = false;
  bool isLoading = false;

  Widget? selectedSubScreen;
  // XFile? selectedImage;
  Uint8List? imageData;

  String? profileImageUrl;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<String> titles = [
    'Dashboard',
    'ITEMS',
    'Categories',
    'Foods',
    'Shipping',
    'ORDERS',
    'Online Orders',
    'COMMUNICATIONS',
    'Push Notifications',
    'Messages',
    'USERS',
    'Administrators',
    'Riders',
    'Customers',
    'REPORTS',
    'Sales Report',
    'Items Report',
    'SETUP',
    'Settings ',
  ];

  List<IconData?> icons = [
    Icons.dashboard_outlined,
    null,
    Icons.category_outlined,
    Icons.fastfood_outlined,
    Icons.local_shipping_outlined,
    null,
    Icons.install_mobile_outlined,
    null,
    Icons.send_to_mobile_outlined,
    Icons.message_outlined,
    null,
    Icons.admin_panel_settings_outlined,
    Icons.delivery_dining_outlined,
    Icons.supervised_user_circle_outlined,
    null,
    Icons.bar_chart_outlined,
    Icons.pie_chart_outline,
    null,
    Icons.settings,
  ];

  List<String> routes = [
    '/dashboard',
    '/items',
    '/categories',
    '/foods',
    '/addons',
    '/shipping',
    '/orders',
    '/online-orders',
    '/communications',
    '/push-notifications',
    '/messages',
    '/users',
    '/administrators',
    '/riders',
    '/customers',
    '/reports',
    '/sales-report',
    '/items-report',
    '/setup',
    '/settings',
  ];

  void toggleScreen(int index) {
    selectedScreenIndex = index;

    appRouter.go(routes[index]);

    notifyListeners();
  }

  // Future<void> pickImage() async {
  //   final result = await FilePicker.platform.pickFiles(type: FileType.image);
  //   if (result != null && result.files.isNotEmpty) {
  //     imageData = result.files.first.bytes;
  //     notifyListeners();
  //   }
  // }

  // Future<void> pickImageFromGallery(BuildContext context) async {
  //   selectedImage = await imagePickerUtils.pickImageFromGallery();
  //   notifyListeners();
  // }

  // Future<void> pickImageFromCamera(BuildContext context) async {
  //   selectedImage = await imagePickerUtils.pickImageFromCamera();
  //   notifyListeners();
  // }

  // Future<void> logout(BuildContext context) async {
  //   log('logout');

  //   final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //   await authNotifier.logOut();

  //   authLocalDataSource.clearAuthData();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('YOUR ACCOUNT IS LOGGED OUT')),
  //   );
  //   context.go('/welcome');
  // }
}
