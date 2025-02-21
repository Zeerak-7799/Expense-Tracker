import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:expense_tracker/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

void main() async  {
  var dir =await getApplicationDocumentsDirectory();
  isar =await Isar.open([CategorySchema,TransactionSchema],directory: dir.path);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
