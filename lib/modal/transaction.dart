import 'package:isar/isar.dart';
part 'transaction.g.dart';

@collection
class Transaction {
  Id id =Isar.autoIncrement;
  int categoryId;
  String? notes;
  double money;
  DateTime? createdOn;

  Transaction({required this.categoryId,this.notes,required this.money,this.createdOn});

}