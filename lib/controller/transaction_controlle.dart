import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class TransactionController {
  var moneyController = TextEditingController();
  var notesController = TextEditingController();
  int? categoryId;
  DateTime? createdOn;

  

  addTransaction({Transaction? trans}) async {
    //update
    if (trans!=null) { 
      trans.money=double.parse(moneyController.text);
      trans.notes=notesController.text;
      trans.createdOn=createdOn;
      trans.categoryId=categoryId!;

      await isar.writeTxn(() async {
      await isar.transactions.put(trans);
    });
      

      // adding new one
    }
    else{
      var t = Transaction(
        categoryId: categoryId!,
        money: double.parse(moneyController.text),
        createdOn: createdOn,
        notes: notesController.text);

    await isar.writeTxn(() async {
      await isar.transactions.put(t);
    });
    }
    
  }

  Future<List<Transaction>> fetchAllTransaction() async {
    var trans = <Transaction>[];
    await isar.writeTxn(() async {
     // trans = await isar.transactions.where().findAll();
        trans = await isar.transactions.where().sortByCreatedOnDesc().findAll();
    });

    return trans;
  }

  removeTransaction(int id) async{
   await isar.writeTxn(() async =>await isar.transactions.delete(id));

  }
}
