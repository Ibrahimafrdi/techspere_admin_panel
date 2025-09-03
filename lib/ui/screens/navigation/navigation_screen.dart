import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/responsive_size_extension.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/locator.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_controller.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation/route_breadcrumb.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation_drawer/navigation_side_bar.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Provider.of<NavigationController>(context);

    return Scaffold(
      // Updated AppBar with dropdown functionality
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Image.asset(
          'assets/images/techspere.png',
          scale: 8,
        ),
        actions: [
          StreamBuilder<User?>(
            stream: authService.authStateChanges,
            builder: (context, snapshot) {
              final user = snapshot.data;
              final displayName = user?.displayName ?? 'Admin';
              final email = user?.email ?? 'No email';

              return PopupMenuButton<String>(
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    children: [
                      displayName.customText(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        fontSize: 14,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_drop_down,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                itemBuilder: (BuildContext context) => [
                  // User Info Header
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Divider(height: 20),
                      ],
                    ),
                  ),
                  // Change Password
                  PopupMenuItem<String>(
                    value: 'change_password',
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,
                            size: 20, color: Colors.grey[700]),
                        const SizedBox(width: 12),
                        const Text('Change Password'),
                      ],
                    ),
                  ),
                  // Logout
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: Colors.red[600]),
                        const SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (String value) async {
                  switch (value) {
                    case 'change_password':
                      _showChangePasswordDialog(context);
                      break;
                    case 'logout':
                      _handleLogout(context);
                      break;
                  }
                },
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: NavigationSideBar(),
          ),
          Expanded(
            flex: 27,
            child: Container(
              height: double.infinity,
              width: context.width,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF7F7FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RouteBreadcrumb(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Helper methods for handling dropdown actions
  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed:
                      isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (newPasswordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Passwords do not match')),
                            );
                            return;
                          }

                          setState(() => isLoading = true);

                          try {
                            await authService.changePassword(
                              currentPasswordController.text,
                              newPasswordController.text,
                            );

                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Password changed successfully')),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${e.toString()}')),
                              );
                            }
                          } finally {
                            setState(() => isLoading = false);
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Change'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authService.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    // Navigate to login screen or handle logout navigation
                    // Navigator.pushReplacementNamed(context, '/login');
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Error logging out: ${e.toString()}')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
