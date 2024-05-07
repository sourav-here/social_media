// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:social_media/models/auth_model.dart';
import 'package:social_media/services/auth_service.dart';
import 'package:social_media/view/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void logout(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Sure about this?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false);
              },
              child: const Text('Logout')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthService().getLoggedUser(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final UserModel? user = snapshot.data;

          if (user != null) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Center(
                  child: Container(
                    height: 500,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(31, 72, 72, 72),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        SizedBox(
                          height: 90,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: const CircleAvatar(
                                minRadius: 90,
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  user.following!.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                Text(
                                  user.followers!.length.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                        ElevatedButton(
                            onPressed: () {
                              logout(context, 0);
                            },
                            child: const Text('Log out'))
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      },
    );
  }
}
