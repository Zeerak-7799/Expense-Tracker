import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/view/myWidget/createcategory.dart';
import 'package:expense_tracker/view/myWidget/custom.dart';
import 'package:flutter/material.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  var categoryCont = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: categoryCont.getAllCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //all categories
              var cat = snapshot.data;
              return GridView.count(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
                children: List.generate(cat!.length, (index) {
                  return GestureDetector(
                    onTap: () async {
                      var c = await editCategorySheet(context,
                          category: cat.elementAt(index));
                      if (c != null) {
                        setState(() {});
                      }
                    },
                    child: categoryBox(
                         IconData(cat.elementAt(index).icon,
                            fontFamily: 'MaterialIcons'),
                        Color(cat.elementAt(index).color),
                        cat.elementAt(index).name),
                  );
                }),
              );
            } else {
              return const Center(
                child: Text('Nothing to preview'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //show bottom sheet for adding new one
        onPressed: () async {
          var c = await createCategorySheet(context);
          if (c != null) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
