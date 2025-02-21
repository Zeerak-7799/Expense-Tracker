import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/controller/transaction_controlle.dart';
import 'package:expense_tracker/modal/category.dart';
import 'package:expense_tracker/modal/transaction.dart';
import 'package:expense_tracker/theme/mycolor.dart';
import 'package:expense_tracker/view/myWidget/numeral.dart';
import 'package:flutter/material.dart';

numpad(BuildContext context, {Category? category, Transaction? transaction}) {
  double height = MediaQuery.of(context).size.height;
  var transactionCont = TransactionController();
  late Category cat;
  var updating = false;

  if (category != null) {
    cat = category;
    transactionCont.categoryId = category.id;
    transactionCont.createdOn = DateTime.now();
  } else if (transaction != null) {
    var catId = transaction.categoryId;
    cat = CategoryController().getById(catId)!;

    transactionCont.categoryId = transaction.categoryId;
    transactionCont.moneyController.text = transaction.money.toString();
    transactionCont.notesController.text = transaction.notes!;
    transactionCont.createdOn = transaction.createdOn;
    updating = true;
  }

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData(
          iconButtonTheme: IconButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(MyColor().naval))),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(MyColor().naval)))),
        child: SizedBox(
          width: double.infinity,
          height: height * .60,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setSheetState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //money  textfield
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                keyboardType: TextInputType.none,
                                controller: transactionCont.moneyController,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: MyColor().naval),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyColor().superSilver,
                                    hintStyle: const TextStyle(fontSize: 24),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    hintText: '0'),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                var s = transactionCont.moneyController.text;
                                if (s.isNotEmpty) {
                                  transactionCont.moneyController.text =
                                      s.substring(0, s.length - 1);
                                  setSheetState(() {});
                                }
                              },
                              icon: const Icon(Icons.backspace_outlined))
                        ],
                      ),
                    ),
                    //options
                    Container(
                      padding:const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        
                        color: MyColor().superSilver,borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //category name
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(cat.color),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              cat.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          //adding notes
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: TextField(
                                        controller:
                                            transactionCont.notesController,
                                        decoration: InputDecoration(
                                            hintText: 'Notes',
                                            border: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok')),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.notes_rounded)),
                          //pick date
                          IconButton(
                              onPressed: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2030));
                      
                                if (date != null) {
                                  var time = TimeOfDay.now();
                                  transactionCont.createdOn = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                                }
                              },
                              icon: const Icon(Icons.calendar_month)),
                      
                          //pick time
                          IconButton(
                              onPressed: () async {
                                var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (time != null) {
                                  var date = transactionCont.createdOn;
                                  transactionCont.createdOn = DateTime(
                                      date!.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute);
                                }
                              },
                              icon: const Icon(Icons.watch_later)),
                        ],
                      ),
                    ),
                    //numpad
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        numeral(
                          num: '7',
                          onTap: () {
                            transactionCont.moneyController.text += '7';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '8',
                          onTap: () {
                            transactionCont.moneyController.text += '8';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '9',
                          onTap: () {
                            transactionCont.moneyController.text += '9';
                            setSheetState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        numeral(
                          num: '4',
                          onTap: () {
                            transactionCont.moneyController.text += '4';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '5',
                          onTap: () {
                            transactionCont.moneyController.text += '5';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '6',
                          onTap: () {
                            transactionCont.moneyController.text += '6';
                            setSheetState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        numeral(
                          num: '1',
                          onTap: () {
                            transactionCont.moneyController.text += '1';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '2',
                          onTap: () {
                            transactionCont.moneyController.text += '2';
                            setSheetState(() {});
                          },
                        ),
                        numeral(
                          num: '3',
                          onTap: () {
                            transactionCont.moneyController.text += '3';
                            setSheetState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        numeral(
                            num: '00',
                            onTap: () {
                              transactionCont.moneyController.text += '00';
                              setSheetState(() {});
                            }),
                        numeral(
                            num: '0',
                            onTap: () {
                              transactionCont.moneyController.text += '0';
                              setSheetState(() {});
                            }),
                        //save button
                        TextButton(
                            onPressed: () async {
                              if (updating) {
                                //update
                                await transactionCont.addTransaction(
                                    trans: transaction);
                              } else {
                                //new one
                                await transactionCont.addTransaction();
                              }
                              Navigator.of(context).pop(true);
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(100, 50))),
                            child: const Icon(
                              Icons.task_alt,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
