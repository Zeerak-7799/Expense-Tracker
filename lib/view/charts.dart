import 'package:expense_tracker/controller/chart_controller.dart';
import 'package:expense_tracker/theme/mycolor.dart';
import 'package:expense_tracker/view/myWidget/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Charts extends StatelessWidget {
  const Charts({super.key});

  @override
  Widget build(BuildContext context) {
    var chartCont = ChartController();
    var pieData = <String, double>{};
    var colorList = <Color>[];
    var total = 0.0;

    return FutureBuilder(
      future: chartCont.getAllCatogeryTotal(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var totalMap = snapshot.data;
          var keys = totalMap!.keys;
          //format pie data
          totalMap.forEach((key, value) {
            pieData[key.name] = value;
            colorList.add(Color(key.color));
            total += value;
          });
          return Column(
            children: [
              //total expense title
              Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColor().shipmate),
                    child: Text(
                      'Total Expense: $total',
                      style:const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
              ),
              //pie chart
              Card(
                  color: Colors.white,
                  child: PieChart(
                    chartType: ChartType.ring,
                    dataMap: pieData,
                    colorList: colorList,
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValueBackground: false),
                  )),
              
              //list of expenses
              Expanded(
                child: ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: categoryTile(keys.elementAt(index)),
                        trailing: Text('${totalMap[keys.elementAt(index)]}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Nothig to previw'),
          );
        }
      },
    );
  }
}
