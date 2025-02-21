import 'package:expense_tracker/theme/mycolor.dart';
import 'package:expense_tracker/view/editcategory.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: MyColor().superSilver,
      child: Column(children: [
        Card(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.edit_note_rounded,color: MyColor().naval,),
            title: Text('Category',style: TextStyle(color: MyColor().naval),),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(context) => const EditCategory(),));
          },),
        )
      ],),
    );
  }
}