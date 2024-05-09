// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:social_media/models/auth_model.dart';
import 'package:social_media/services/auth_service.dart';
import 'package:social_media/view/signup_page.dart';
import 'package:social_media/view/user_list.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter Email',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter correct Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter password',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter correct password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 40,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          final status = await AuthService().login(
                              context,
                              AuthModel(
                                  email: emailController.text,
                                  password: passwordController.text));
                          if (status == 'success') {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const UserList(),
                            ));
                          } else {
                            return;
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 143, 135, 135)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
