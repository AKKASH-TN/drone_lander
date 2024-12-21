// ignore: file_names
import 'package:drone_lander/presentation/pages/analyticspage.dart';
import 'package:drone_lander/presentation/pages/homepage.dart';
import 'package:drone_lander/presentation/pages/manualpage.dart';

import 'package:drone_lander/presentation/pages/profilepage.dart';
import 'package:drone_lander/presentation/pages/settings.dart';
import 'package:drone_lander/presentation/pages/supportpage.dart';
import 'package:drone_lander/presentation/pages/videointerfacepage.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black38,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header with User Profile
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white54,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/akkash.jpg'),
            ),
            accountName: Text(
              'Akkash',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(
              'HackerAsh@gmail.com',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          // Navigation Items
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Homepage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.manage_search_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Manual',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Manualpage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.analytics,
              color: Colors.white,
            ),
            title: const Text(
              'Analytics',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Analyticspage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.videocam,
              color: Colors.white,
            ),
            title: const Text(
              'Video Interface',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Videointerfacepage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
        
          ListTile(
            leading: const Icon(
              Icons.chat_bubble,
              color: Colors.white,
            ),
            title: const Text(
              'Support',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Supportpage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
          const Divider(color: Colors.grey),
          // Settings Section
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Profilepage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Settings(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              // Add navigation logic here
            },
          ),
          const Divider(color: Colors.grey),
          // Logout Option
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              // Add logout logic here
            },
          ),
        ],
      ),
    );
  }
}
