//提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor> [
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
    static SharedPreferences _prefs;
    static Profile profile = Profile();

    //可选的主题列表
    static List<MaterialColor> get thems => _themes;

    //是否为release版本
    static bool get isRelease => bool.fromEnvironment("dart.vm.product");

    //初始化全局信息，会在APP启动时执行
    static Future init() async {
      _prefs = await SharedPreferences.getInstance();
      var _profile = _prefs.getString("profile");
      if(_profile != null) {
        try {
          profile = Profile.fromJson(jsonDecode(_profile));
        } catch (e) {
          print(e);
        }
      }

      //如果没有缓存策略，设置默认缓存策略
    }
}