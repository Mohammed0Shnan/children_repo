import 'package:flutter/cupertino.dart';
import 'package:child_app/data/models/item_response.dart';
import 'package:child_app/data/repositories/item_repository.dart';
import 'package:rxdart/rxdart.dart';

class ItemByIdBloC{
  final ItemRepository _repository = ItemRepository();
  final BehaviorSubject<ItemResponse> _subject = BehaviorSubject<ItemResponse>();

  getItemById(int id) async {
    ItemResponse response = await _repository.getItemById(id);
    _subject.sink.add(response);
  }

drainStream(){
  _subject.value = null;
}
@mustCallSuper
  void despose() {
    _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ItemResponse> get subject => _subject;
}

final ItemByIdBloC itemByIdBloC = ItemByIdBloC();