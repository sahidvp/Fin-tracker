import 'package:finance_tracker/data/userdetails.dart';
import 'package:finance_tracker/screens/Help.dart';
import 'package:finance_tracker/screens/homepage.dart';

import 'package:finance_tracker/screens/loginpage.dart';

import 'package:finance_tracker/screens/personaldetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: mycolor,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    return const HomePage();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))),
        body: const ContainerStackExample(),
      ),
    );
  }
}

class ContainerStackExample extends StatelessWidget {
  const ContainerStackExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: username.listenable(),
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: 290,
                  ),
                  ClipPath(
                    clipper: BottomOvalClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      color: const Color.fromARGB(255, 18, 54, 52),
                    ),
                  ),
                  Positioned(
                    left: 160,
                    top: 180,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 8, 94, 89),
                          shape: BoxShape.circle),
                      child: Image.asset('asset/image/user avatar.png'),
                    ),
                  ),
                ],
              ),
              Text(
                getusername(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Color.fromARGB(255, 18, 54, 52),
                ),
              ),
              Text(
                getemail(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color.fromARGB(255, 18, 54, 52),
                ),
              ),
              const SizedBox(height: 50),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const PersonalDetails();
                  }));
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.people_alt_sharp,
                    color: Color.fromARGB(255, 39, 97, 94),
                    size: 28,
                  ),
                  title: Text(
                    'Personal Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  shareApp();
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.share,
                    color: Color.fromARGB(255, 39, 97, 94),
                    size: 28,
                  ),
                  title: Text(
                    'Share application',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const Help();
                  }));
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Color.fromARGB(255, 39, 97, 94),
                    size: 28,
                  ),
                  title: Text(
                    'Help',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 39, 97, 94),
                    size: 28,
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () async {
                // Clear the shared preference value
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);

                // Navigate to the login screen
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> shareApp() async {
    // Set the app link and the message to be shared
    const String appLink =
        'https://play.google.com/store/apps/details?id=com.example.myapp';
    const String message = 'Check out my new app: $appLink';

    // Share the app link and message using the share dialog
    await FlutterShare.share(
        title: 'Share App', text: message, linkUrl: appLink);
  }
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Start from the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 30); // Create a quadratic bezier curve
    path.lineTo(size.width, 0); // Line to the top-right corner
    path.close(); // Close the path to complete the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
