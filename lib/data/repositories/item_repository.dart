import 'package:child_app/consts/url.dart';
import 'package:child_app/data/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:child_app/data/models/item_response.dart';
import 'package:child_app/util/dume_data.dart';

class ItemRepository {
  static final  getBehaviorUrl = Urls.DOMAIN+'/behaviours';
  static final  getBehaviorByIdUrl = '';
  static final  addItemUrl =   Urls.DOMAIN +'/behaviours';

  Future<ItemResponse> getItems() async {
   
    //          return await Future.delayed(Duration(seconds: 2), () {
    //      ItemResponse result1 = ItemResponse.fromJson(apiitemsResult);
    //  return result1;
    //   });

    try {
      http.Response response = await http.get(getBehaviorUrl);
      ItemResponse itemResponse =
          ItemResponse.fromJson(json.decode(response.body));
      return itemResponse;
    } catch (errorValue, stackTrace) {
      print(
          'Error in items fetching , Error : $errorValue , and trace : $stackTrace');
      return ItemResponse.withError(errorValue.toString());
    }
  }

  Future<ItemResponse> getItemById(int id) async {
    try {
      http.Response response = await http.get(getBehaviorByIdUrl);
      ItemResponse itemResponse =
          ItemResponse.fromJson(json.decode(response.body));
      return itemResponse;
    } catch (errorValue, stackTrace) {
      print(
          'Error in items by id fitching , Error : $errorValue , and trace : $stackTrace ');
      return ItemResponse.withError(errorValue);
    }
  }

  Future<ItemModel> addItem(ItemModel item) async {
    try {
      http.Response response = await http.post(addItemUrl,
      body: {
      'name':item.name,
      'description':item.description,
      'type':item.type,
      'points':'${item.points}',
      'typeName':item.typeName
      },
      headers: {
        'Accept':'application/json'
      }
      );
     Map map =  json.decode(response.body);
      ItemModel itemModel =ItemModel.fromJson(map['behaviour']);
     return itemModel;
    } catch (errorValue, stackTrace) {
      print(
          'Error in add items , Error : $errorValue , and trace : $stackTrace ');
      return null;
    }
  }

}
