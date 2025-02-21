import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class CategoryController {
  var name = TextEditingController();
  Color? color;
  IconData? icon;

  addCategory({Category? updateCat}) async {
    // updating
    if (updateCat != null) {
      updateCat.name = name.text;
      updateCat.color = color!.value;
      updateCat.icon = icon!.codePoint;
      await isar.writeTxn(() => isar.categorys.put(updateCat));
    }
    //writing new
    else {
      var c =
          Category(name: name.text, color: color!.value, icon: icon!.codePoint);
      await isar.writeTxn(() => isar.categorys.put(c));
      name.clear();
    }
  }

  Future<List<Category>> getAllCategory() async {
    var category = <Category>[];

    await isar.writeTxn(() async {
      category = await isar.categorys.where().findAll();
    });

    return category;
  }

  Category? getById(int id)  {
    Category? cat;
    cat= isar.categorys.getSync(id);
    return cat;
  }

  removeCategory(Category c) async {

    await isar.writeTxn(() async {
      await isar.transactions.filter().categoryIdEqualTo(c.id).deleteAll();
      await isar.categorys.delete(c.id);
    });
  }
}
