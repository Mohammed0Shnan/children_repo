import 'package:flutter/material.dart';

class IngrediantProgress extends StatelessWidget {
  final String ingrediant;
  final Color progressColor;
  final double percentage;
  const IngrediantProgress({
    Key key, this.ingrediant, this.progressColor, this.percentage,
  }) : super(key: key);
 @override
  Widget build(BuildContext context) {
        double per=0 ;
    if(percentage<=10){
  per =percentage/10;
    }
    else if(percentage>10 && percentage<=100){
        per = percentage/100;
    }
    else{
     per = percentage/1000;
    }
    return Container(
      margin: EdgeInsets.only(top:5),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('%'+percentage.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width:15),
          Stack(
            children: <Widget>[
              Container(
                width: 110,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
               Container(
                width: 110 *per ,
                height: 15,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),

            ],
          ),
          Spacer(),
          Text(ingrediant,overflow: TextOverflow.ellipsis,style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.black)),
         Spacer(),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            height: 10,
            width: 10,
            decoration:BoxDecoration(
              color: progressColor,
              shape:BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }

}