import 'package:child_app/data/models/child.dart';
import 'package:child_app/data/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:child_app/data/models/user_response.dart';
import 'package:child_app/data/repositories/user_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloC {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject = BehaviorSubject();
  static SharedPreferences _sharedPrefrences;
  UserBloC() {
    getToken().then((value) {
      _subject.add(UserResponse(token: value, error: ''));
    });
  }

  Future<void> storeToken(String token) async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    _sharedPrefrences.setString('childToken', token);
  }

  Future<String> getToken() async {
    _sharedPrefrences = await SharedPreferences.getInstance();
    String _token = _sharedPrefrences.get('childToken');
    return (_token == null) ? null : _token.toString();
  }

  Future<UserResponse> login(User user) async {
    UserResponse userResponse = await _repository.login(user);
    _subject.sink.add(userResponse);
    storeToken(userResponse.token);

    return UserResponse(
        token: userResponse.token,
        error: '',
        child: Child(
            name: 'mohammed',
            points: 100,
            gender: 'male',
            dob: '2010-10-10',
            id: 10));
  }

  logout() async {
    storeToken(null);
    _subject.sink.add(UserResponse(token: null, error: ''));
  }

  drainStream() {
    _subject.stream.drain();
  }

  @mustCallSuper
  despose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

  Future<UserResponse> getUser() async {
    // _sharedPrefrences.getString('child_token').then((value) {
    //   _subject.add(UserResponse(token: value.toString(),error: null));
    // });
    await Future.delayed(Duration(seconds: 2));
    _subject.sink.add(UserResponse(
        token: 'fasdfwf',
        error: '',
        child: Child(
            name: 'mohammed',
            points: 100,
            gender: 'male',
            dob: '2010-10-10',
            id: 10)));
    return UserResponse();
  }

  register(User user) async {
    UserResponse userResponse = await _repository.register(user);
    
    if (userResponse.error != null && userResponse.error.length > 0) {
      return null;
    } else{
      storeToken(userResponse.token);
      return userResponse;
    }
  
  }
}

final UserBloC userBloC = UserBloC();
