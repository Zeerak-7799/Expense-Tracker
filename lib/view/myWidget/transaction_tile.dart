import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:expense_tracker/theme/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget transactionTile(Transaction transaction) {
  var categoryCont = CategoryController();
  Category cat = categoryCont.getById(transaction.categoryId)!;

  {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Card(
          color: Colors.white,
          child: ListTile(
            isThreeLine: true,
            title: categoryTile(cat),
            //notes + date time
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(transaction.notes!,style: TextStyle(color: MyColor().naval),),
                ),
                Padding(
                  padding:const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(DateFormat.MMMEd().format(transaction.createdOn!),style: TextStyle(color: MyColor().shipmate,fontSize: 12)),
                      const Text('  '),
                      Text(DateFormat.jm().format(transaction.createdOn!),style: TextStyle(color: MyColor().shipmate,fontSize: 12))
                    ],
                  ),
                ),
              ],
            ),
            // money title
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FittedBox(child: Text(transaction.money.toString(),style: TextStyle(color: MyColor().naval,fontSize: 16),)),
            ),
          ),
        ));
  }
}

Row categoryTile(Category cat) {
  return Row(
            children: [
              //category title
              Container(
                decoration: BoxDecoration(
                    color: Color(cat.color),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(IconData(cat.icon, fontFamily: 'MaterialIcons',),color: Colors.white,size: 15,),
                      const SizedBox(width: 5,),
                      Text(cat.name,style:const TextStyle(color: Colors.white,fontSize: 14),)
                    ],
                  ),
                ),
              ),
            ],
          );
}
