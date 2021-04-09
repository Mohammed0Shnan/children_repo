
import 'dart:convert';
import 'package:child_app/consts/url.dart';
import 'package:http/http.dart'as http;
import 'package:child_app/data/models/child.dart';
import 'package:child_app/data/models/child_response.dart';

class ChildRepository{

  static final String getChildrenUrl = Urls.DOMAIN+'/children';
    static final String getChildByIdUrl = '/getchildById/';
    static final String addChildUrl = Urls.DOMAIN+'/children';
  
  Future<ChildResponse> getChildren() async{
    //  return await Future.delayed(Duration(seconds: 2), () {
    //     ChildResponse result1 = ChildResponse.fromJson(apiResult);
    //     return result1;
    //   });
    try{
     http.Response response = await http.get(getChildrenUrl);
     ChildResponse childResponse = ChildResponse.fromJson(json.decode(response.body)); 
     return childResponse;
    }catch(errorValue,stackTrace){
      print("Error in children fetching , Error: $errorValue , and track : $stackTrace");
      return ChildResponse.withError(errorValue.toString());
    }
  }
  Future<ChildResponse> getChildById(String id) async{
    try{
      http.Response response = await http.get(getChildByIdUrl);
      ChildResponse childResponse = ChildResponse.fromJson(json.decode(response.body));
      return childResponse;
    }catch(errorValue,stackTrace){
       print('Error in child fetching , Error: $errorValue , and trace : $stackTrace');
       return ChildResponse.withError(errorValue);
    }
  }

 Future<ChildResponse> addChild(Child child) async{
   String date = '${child.dob.year}-${child.dob.month}-${child.dob.day}';
      try{
      http.Response response = await http.post(addChildUrl,
      headers: {
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name':child.name,
        'gender':child.gender,
        'DOB':date,

      })
      );
      ChildResponse childResponse = ChildResponse.fromJson(json.decode(response.body));
      return childResponse;
    }catch(errorValue,stackTrace){
       print('Error in child adding , Error: $errorValue , and trace : $stackTrace');
       return ChildResponse.withError(errorValue);
    }

  }
}
