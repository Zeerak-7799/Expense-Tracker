import 'package:isar/isar.dart';
part 'category.g.dart';

@collection
class Category {
  Id id =Isar.autoIncrement;

  String name;
  int color;
  int icon;

  Category(
      {
      required this.name,
      required this.color,
      required this.icon});
}
