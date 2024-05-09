import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/services/auth_service.dart';

class PasswordChange extends StatelessWidget {
  PasswordChange({super.key});

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
                height: 600,
                width: 400,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 72, 72, 72),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(55.0),
                  child: Column(
                    children: [
          const SizedBox(height: 60),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
                hintText:'Enter new password', border: OutlineInputBorder()),
          ),
          const Gap(30),
          ElevatedButton(
              onPressed: () async {
                await AuthService()
                    .changePassword(context, passwordController.text);
                passwordController.clear();
              },
              child: const Text('Save'))
                    ],
                  ),
                ),
              ),
        ));
  }
}
