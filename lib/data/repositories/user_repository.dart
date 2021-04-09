
import 'package:child_app/consts/url.dart';
import 'package:child_app/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:child_app/data/models/user_response.dart';
class UserRepository{
  static final loginUrl = Urls.DOMAIN+'/login';
  static final signupUrl = Urls.DOMAIN+'/register';

  Future<UserResponse> login(User user) async {
    try{
      http.Response response = await http.post(loginUrl,
      body: {
        'email':user.email,
        'password':user.password
      },
      headers: {
        'Accept':'application/json'
      }
      );
      UserResponse userResponse = UserResponse.fromJson(json.decode(response.body));
      return userResponse;
    }catch(errorValue  ,stackTrace){
      print('Error in login , Error : $errorValue , and trace : $stackTrace');
      return UserResponse.withError(errorValue.toString());
    }
  }

  register(User user)async {
    print(user.name);
     print(user.email);
      print(user.password);
        try{
      http.Response response = await http.post(signupUrl,body:user.toJson(),
      headers: {
        'Accept':"application/json"
      }
       );
       print(response.body);
      UserResponse userResponse = UserResponse.fromJson(json.decode(response.body));
     
      return userResponse;
    }catch(errorValue  ,stackTrace){
      print('Error in Register , Error : $errorValue , and trace : $stackTrace');
      return UserResponse.withError(errorValue.toString());
    }
  }
  }
  
