import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/controller/transaction_controlle.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/theme/mycolor.dart';
import 'package:expense_tracker/view/myWidget/numpad.dart';
import 'package:expense_tracker/view/myWidget/transaction_tile.dart';
import 'package:flutter/material.dart';

class ListOfTransaction extends StatefulWidget {
  const ListOfTransaction({super.key});

  @override
  State<ListOfTransaction> createState() => _ListOfTransactionState();
}

class _ListOfTransactionState extends State<ListOfTransaction> {
  @override
  Widget build(BuildContext context) {
    var transCont = TransactionController();
    return Container(
      color: MyColor().superSilver,
      child: FutureBuilder(
        future: transCont.fetchAllTransaction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var trans = snapshot.data;
            return ListView.builder(
              itemCount: trans!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async{
                      var c=await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          var categoryCont = CategoryController();
                          Category cat = categoryCont
                              .getById(trans.elementAt(index).categoryId)!;
                          return Container(
                            padding:const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // title + money
                                  ListTile(
                                    title: categoryTile(cat),
                                    trailing: Text(
                                        trans.elementAt(index).money.toString()),
                                  ),
                                  const Divider(),
      
                                  //update tile
                                   ListTile(
                                    onTap: () async{
                                      var c= await numpad(context,transaction: trans.elementAt(index));
                                      if (c!=null&&context.mounted) {
                                        Navigator.of(context).pop(true);
                                      }
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Update'),
                                  ),
                                  const Divider(),
      
                                  //remove
                                  ListTile(
                                    onTap: () async{
                                      //confirmation dialog
                                      var c =await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                             const Text('Are you sure to remove?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child:const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  transCont.removeTransaction(
                                                      trans.elementAt(index).id);
                                                  Navigator.of(context).pop(true);
                                                },
                                                child:const Text('Ok')),
                                          ],
                                        );
                                      },
                                    );
                                    if (c!=null&&context.mounted) {
                                      Navigator.of(context).pop(true);
                                    }
                                    },
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Remove'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    if (c!=null) {
                      setState(() {});
                    }
                    },
                    child: transactionTile(trans.elementAt(index)));
              },
            );
          } else {
            return const Center(
              child: Text('Nothing to preview'),
            );
          }
        },
      ),
    );
  }
}
