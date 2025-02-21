import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

createCategorySheet(BuildContext context,{Category? category}) {
  var categoryCont = CategoryController();
  var title ='Add Category';
  if (category!=null) {
    categoryCont.name.text=category.name;
    categoryCont.color=Color(category.color);
    categoryCont.icon=IconData(category.icon,fontFamily: 'MaterialIcons');
    title ='Edit Category';
  }
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setModalState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //title tile cancel button
                  ListTile(
                    leading: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.cancel)),
                    title:  Center(
                      child: Text(title),
                    ),
                    //save button
                    trailing: GestureDetector(
                      onTap: () {
                        //for update
                        if (category!=null) {
                          categoryCont.addCategory(updateCat: category);
                        }
                        //for new one
                        else{
                          categoryCont.addCategory();
                        }
                        
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: const Text('Save'),
                      ),
                    ),
                  ),
                  const Divider(),
                  // add/update category name
                  ListTile(
                    leading: const Icon(Icons.notes),
                    title: TextField(
                      controller: categoryCont.name,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: 'Untitled'),
                    ),
                  ),
                  const Divider(),

                  //selecting color
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: BlockPicker(
                              pickerColor: Colors.black,
                              onColorChanged: (value) {
                                categoryCont.color = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    setModalState(() {});
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ok'))
                            ],
                          );
                        },
                      );
                    },
                    leading: const Icon(Icons.color_lens),
                    title: const Text('Color'),
                    trailing: CircleAvatar(
                      radius: 15,
                      backgroundColor: categoryCont.color ?? Colors.black,
                    ),
                  ),
                  const Divider(),

                  //selecting icon
                  ListTile(
                    onTap: () async {
                      categoryCont.icon = (await showIconPicker(
                          iconSize: 25,
                          iconPickerShape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          context)) as IconData?;
                      setModalState(() {});
                    },
                    leading: const Icon(Icons.photo),
                    title: const Text('Icon'),
                    trailing: CircleAvatar(
                      radius: 20,
                      child: Icon((categoryCont.icon ?? Icons.ac_unit)),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

editCategorySheet(BuildContext context, {Category? category}) {
  var categoryCont = CategoryController();
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title and cancel button
            ListTile(
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.cancel)),
              title: Center(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(category!.color),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      category.name,
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ),
            const Divider(),

            //update category
            ListTile(
              onTap: () async{
                
                var c= await createCategorySheet(context,category: category);
                if (c!=null&&context.mounted) {
                  Navigator.of(context).pop(true);
                }
              },
              leading: const Icon(Icons.edit),
              title: const Text('Update'),
            ),

            const Divider(),

            //Remove category
            ListTile(
              onTap: () async {
                //confirmation dialog
                var c = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                        'Are you sure to remove category ${category.name} ? All releated transation will also deleted.' ),
                    actions: [
                      //cancel btn
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel')),
                      //ok btn
                      TextButton(
                          onPressed: () {
                            categoryCont.removeCategory(category);
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Ok')),
                    ],
                  ),
                );
                if (c!=null) {
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                  
                }
              },
              leading: const Icon(Icons.delete),
              title: const Text('Remove'),
            ),
          ],
        ),
      );
    },
  );
}
