import 'package:flutter/material.dart';
import 'package:social_media/view/change_password.dart';

class DetailScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  const DetailScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(31, 72, 72, 72),
        title: const Text('Details'),
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(31, 72, 72, 72)
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.person,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              Text(
                'Name: $userName',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Email: $userEmail',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordChange()));
                },
                child: const Text('change password',
                    style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
