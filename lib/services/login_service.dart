import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:testks2022/env.dart';
import 'package:testks2022/models/user_model.dart';

Future<UserModel> LoginService(String email, String password) async {
  String hashedPassword = md5.convert(utf8.encode(password)).toString();
  final String url = URL + "/user/" + email + "/" + hashedPassword;
  print(email + ", pass : " + password);
  final response = await http.get(Uri.parse(url), headers: <String, String>{
    'Content-Type': 'application/son; charset=utf-8',
  });
  print(response.body);
  return UserModel.fromJson(json.decode(response.body));
  /*
  if(response.statusCode == 200){
    //print(response);
    
  }else{
    throw Exception('Failed to Login');
  }
  */
}
