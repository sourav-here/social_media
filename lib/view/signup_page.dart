import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/models/auth_model.dart';
import 'package:social_media/services/auth_service.dart';
import 'package:social_media/view/login_page.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(31, 72, 72, 72),
              borderRadius: BorderRadius.circular(10)),
          height: 600,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.mail)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          hintText: 'Enter a username',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid username';
                        } else {
                          return null;
                        }
                      }),
                  const Gap(40),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          AuthService().signUp(
                              context,
                              AuthModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: usernameController.text));

                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        }
                      },
                      child: const Text('SignUp',style: TextStyle(color: Colors.white),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
