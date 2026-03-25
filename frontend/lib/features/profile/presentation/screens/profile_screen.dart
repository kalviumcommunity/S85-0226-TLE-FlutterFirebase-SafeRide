import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../widgets/common/custom_button.dart';
import '../../../auth/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer2<ThemeProvider, AuthProvider>(
        builder: (context, themeProvider, authProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  authProvider.currentUser?.email ?? 'Guest User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                
                // Settings Section
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Dark Mode Toggle
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle dark theme'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                  secondary: Icon(
                    themeProvider.isDarkMode 
                        ? Icons.dark_mode 
                        : Icons.light_mode,
                  ),
                ),
                
                const Divider(),
                
                // Notifications
                const ListTile(
                  title: Text('Notifications'),
                  subtitle: Text('Manage notification preferences'),
                  leading: Icon(Icons.notifications),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                
                // Privacy
                const ListTile(
                  title: Text('Privacy'),
                  subtitle: Text('Privacy and security settings'),
                  leading: Icon(Icons.privacy_tip),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                
                // Help
                const ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Get help and support'),
                  leading: Icon(Icons.help),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                
                const Spacer(),
                
                // Sign Out Button
                CustomButton(
                  text: 'Sign Out',
                  onPressed: () async {
                    await authProvider.signOut();
                  },
                  backgroundColor: Colors.red,
                  isLoading: authProvider.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
