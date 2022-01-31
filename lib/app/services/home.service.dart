import 'dart:convert';
import 'dart:math';

import 'package:employee/app/models/user.model.dart';
import 'package:employee/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<User>> getAll() async {
    var url = Uri.parse('https://reqres.in/api/users');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var users = data['data'] as List;
    return users.map((user) => User.fromJson(user)).toList();
  }

  Future<User> getDetail(int id) async {
    var url = Uri.parse('https://reqres.in/api/users/$id');
    var response = await http.get(url);
    var data = json.decode(response.body);
    return User.fromJson(data['data']);
  }

  create(user) async {
    try {
      var url = Uri.parse('https://reqres.in/api/users');
      var response = await http.post(url, body: user);
      var data = await json.decode(response.body);
      Get.defaultDialog(
        title: 'Success',
        content: Text('User created successfully'),
        actions: [
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Something went wrong'),
        actions: [
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
    }
  }
}
