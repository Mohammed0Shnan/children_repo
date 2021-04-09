import 'package:child_app/data/models/child.dart';
import 'package:flutter/material.dart';
import 'package:child_app/data/models/child_response.dart';
import 'package:child_app/data/repositories/child_repository.dart';
import 'package:rxdart/subjects.dart';

class ChildCrudBloC  {
  final ChildRepository _repository = ChildRepository();
  final BehaviorSubject<ChildResponse> _subject = BehaviorSubject();
  

   addChild(Child child) async {

     ChildResponse response = await _repository.addChild(child);
     _subject.sink.add(response);
 }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void despose() {
    _subject.drain();
    subject.close();
  }

  BehaviorSubject<ChildResponse> get subject => _subject;
}

