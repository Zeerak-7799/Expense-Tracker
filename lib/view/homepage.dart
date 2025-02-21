import 'package:expense_tracker/controller/category_controller.dart';
import 'package:expense_tracker/theme/mycolor.dart';
import 'package:expense_tracker/view/charts.dart';
import 'package:expense_tracker/view/listoftransaction.dart';
import 'package:expense_tracker/view/myWidget/custom.dart';
import 'package:expense_tracker/view/myWidget/numpad.dart';
import 'package:expense_tracker/view/setting.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var navBarIndex = 0;
  var body = <Widget>[
    const HomepageBody(),
    const ListOfTransaction(),
    const Charts(),
    const Setting()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        backgroundColor: MyColor().shipmate,
        foregroundColor: Colors.white,
      ),
      body: body.elementAt(navBarIndex),

      //bottom Nav Bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: MyColor().shipmate,
        indicatorColor: MyColor().naval,
        
        selectedIndex: navBarIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (value) {
          navBarIndex = value;
          setState(() {});
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
              icon: Icon(Icons.grid_view_rounded,color: Colors.white,), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.view_list_rounded,color: Colors.white), label: 'List'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_rounded,color: Colors.white), label: 'Charts'),
          NavigationDestination(
              icon: Icon(Icons.settings_rounded,color: Colors.white), label: 'Setting'),
        ],
      ),
    );
  }
}

class HomepageBody extends StatelessWidget {
  const HomepageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // 
    var categoryCont = CategoryController();
    return Container(
        color: MyColor().superSilver,
        padding:const EdgeInsets.all(8),
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
                    onTap: ()async {
                      await numpad(context,category: cat.elementAt(index));
                    },
                    child: categoryBox(
                        IconData(cat.elementAt(index).icon,fontFamily: 'MaterialIcons'),
                        Color(cat.elementAt(index).color),
                        cat.elementAt(index).name),
                  );
                }),);
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
