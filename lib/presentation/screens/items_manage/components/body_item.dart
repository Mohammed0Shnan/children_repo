import 'dart:ffi';

import 'package:child_app/business_logic/blocs/item_crud_bloc.dart';
import 'package:child_app/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:child_app/business_logic/blocs/child_crud_bloc.dart';
import 'package:child_app/data/models/child.dart';
import 'package:child_app/data/models/child_response.dart';

import 'package:child_app/presentation/widgets/error_widget.dart';
import 'package:child_app/presentation/widgets/loading_widget.dart';
import 'package:child_app/presentation/widgets/rounded_button.dart';
import 'package:child_app/presentation/widgets/rounded_input_feild.dart';
import 'package:child_app/presentation/widgets/succes_widget.dart';
import 'package:child_app/util/size_config.dart';

class BodyItem extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<BodyItem> {
  String _name;
  String _description;
  String _type;
  double _point;
  String _typeName;

  bool active = false;
  final ItemCrudBloC itemCrudBloC = ItemCrudBloC();
  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Form(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                RoundedInputFeild(
                  hintText: 'ادخل الاسم',
                  icon: Icons.person,
                  isSecure: false,
                  valueChanged: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: SizeConfig.screenWidth * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(30)),
                  child: PopupMenuButton<String>(
                    onSelected: (op) {
                      setState(() {
                        _typeName = op;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      List<String> options = ['Behaviour', 'Skill', 'Goal'];
                      return List.generate(
                          3,
                          (index) => PopupMenuItem<String>(
                              value: options[index].toString(),
                              child: Text(options[index])));
                    },
                    child: Text('ادخل اسم النوع'),
                  ),
                ),
                SizedBox(height: 10),
                                Container(
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(30)),
                  width: SizeConfig.screenWidth * 0.8,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile<String>(
                          value: 'Good',
                          activeColor: Colors.blueAccent,
                          onChanged: (v) {
                            setState(() {
                              _type = v;
                            });
                          },
                          title: Text('جيد'),
                          groupValue: _type,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          activeColor: Colors.blueAccent,
                          value: 'Bad',
                          onChanged: (v) {
                            setState(() {
                              _type = v;
                            });
                          },
                          title: Text('سيئ'),
                          groupValue: _type,
                        ),
                      )
                    ],
                  ),
                ),
          
                SizedBox(height: 10),
                RoundedInputFeild(
                  hintText: 'ادخل النقط',
                  icon: Icons.person,
                  isSecure: false,
                  valueChanged: (value) {
                    _point = double.parse(value) ;
                  },
                ),
                SizedBox(height: 10),
                Container(
                  width: SizeConfig.screenWidth * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    maxLines: 7,
                    minLines: 5,
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'ادخل الوصف',
                        icon: Icon(Icons.description),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RoundedButton(
                  text: 'اضافة',
                  onPress: () {
                    setState(() {
                      active = !active;
                    });
                    itemCrudBloC.addItem(ItemModel(
                        name: _name.toString(),
                        points: _point,
                        type: _type.toString(),
                        typeName: _typeName.toString(),
                        description: _description.toString()));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<ItemModel>(
                  stream: itemCrudBloC.subject.stream,
                  builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                    if (snapshot.hasData) {
                      return buildSuccesWidget(
                        message: 'Successfuly !!!',
                      );
                    } else if (snapshot.hasError) {
                      return buildErrorWidget(context, error: '');
                    } else if (snapshot.connectionState ==
                            ConnectionState.waiting &&
                        active == true) {
                      return buildLoadingWidget();
                    } else {
                      return SizedBox(
                        height: 10,
                        width: 10,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
