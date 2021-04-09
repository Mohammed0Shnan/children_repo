import 'package:child_app/data/models/item_model.dart';
import 'package:child_app/data/models/item_response.dart';
import 'package:child_app/data/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class ItemCrudBloC  {
  final ItemRepository _repository = ItemRepository();
  final BehaviorSubject<ItemModel> _subject = BehaviorSubject();


  addItem(ItemModel item) async {

    ItemModel response = await _repository.addItem(item);
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

  BehaviorSubject<ItemModel> get subject => _subject;
}
final ItemCrudBloC itemCrudBloC = ItemCrudBloC();