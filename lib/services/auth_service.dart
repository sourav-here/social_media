// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/models/auth_model.dart';
import 'package:dio/dio.dart';

class AuthService {
  Dio dio = Dio();
  Future<AuthModel?> signUp(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'https://social-media-5ukj.onrender.com/auth/register',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 201) {
        log('account created');

        final jsonData = AuthModel.fromJson(response.data);
        return jsonData;
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<String> login(BuildContext context, AuthModel authModel) async {
    try {
      final response = await dio.post(
          'https://social-media-5ukj.onrender.com/auth/login',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: authModel.toJson());

      if (response.statusCode == 200) {
        log('logged in successfully');
        final jsonData = response.data as Map<String, dynamic>;
        String token = jsonData['token'];
        String status = jsonData['status'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('Token', token);
        pref.setString('Status', status);
        return status;
      } else {
        throw Exception('user not found ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Something went wrong $e');
    }
  }

  Future<UserModel?> getLoggedUser(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('Token');
      final response = await dio.get(
        'https://social-media-5ukj.onrender.com/auth/loggeduser',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = UserModel.fromJson(response.data);
        return jsonData;
      } else {
        throw Exception('Failed to get logged-in user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}