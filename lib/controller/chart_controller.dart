import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:isar/isar.dart';

class ChartController {
  
  Future<Map<Category, double>> getAllCatogeryTotal() async {
    var catList = <Category>[];
    var categoryTotal = <Category, double>{};
    await isar.writeTxn(() async {
      catList = await isar.categorys.where().findAll();
    });

    for (var category in catList) {
      var transList = <Transaction>[];
      await isar.writeTxn(() async {
        transList = await isar.transactions
            .filter()
            .categoryIdEqualTo(category.id)
            .findAll();
      });
      var sum=0.0;
      //sum same category money
      for (var transaction in transList) {
        sum+=transaction.money;
      }
      
      if (sum!=0) {
      categoryTotal[category]=sum;
      }
      
    }
    return categoryTotal;
  }
}
