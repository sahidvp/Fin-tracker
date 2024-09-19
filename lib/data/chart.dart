
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:finance_tracker/db/add_date.dart';
// import 'package:finance_tracker/data/utility.dart';

// class Chart extends StatefulWidget {
//   final int indexx;

//   const Chart({super.key, required this.indexx});

//   @override
//   State<Chart> createState() => _ChartState();
// }

// class _ChartState extends State<Chart> {
//   Color mycolor = const Color.fromARGB(255, 18, 54, 52);
//   List<Add_data>? a;
//   bool b = true;
//   bool j = true;

//   @override
//   Widget build(BuildContext context) {
//     switch (widget.indexx) {
//       case 0:
//         a = today();
//         b = true;
//         j = true;
//         break;
//       case 1:
//         a = week();
//         b = false;
//         j = true;
//         break;
//       case 2:
//         a = month();
//         b = false;
//         j = true;
//         break;
//       case 3:
//         a = year();
//         j = false;
//         break;
//       default:
//     }
//     return SizedBox(
//       width: double.infinity,
//       height: 300,
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//         series: <SplineSeries<SalesData, String>>[
//           SplineSeries<SalesData, String>(
//             name: 'Income',
//             color: Colors.green, // Set color for income line
//             width: 3,
//             dataSource: generateChartData(a, true),
//             xValueMapper: (SalesData sales, _) => sales.year,
//             yValueMapper: (SalesData sales, _) => sales.income,
//           ),
//           SplineSeries<SalesData, String>(
//             name: 'Expense',
//             color: Colors.red, // Set color for expense line
//             width: 3,
//             dataSource: generateChartData(a, false),
//             xValueMapper: (SalesData sales, _) => sales.year,
//             yValueMapper: (SalesData sales, _) => sales.expense,
//           ),
//         ],
//       ),
//     );
//   }

// List<SalesData> generateChartData(List<Add_data>? data, bool isIncome) {
//   return List.generate(time(data!, b).length, (index) {
//     return SalesData(
//       j
//           ? (b
//               ? data[index].datetime.hour.toString()
//               : data[index].datetime.day.toString())
//           : data[index].datetime.month.toString(),
//       b
//           ? index > 0
//               ? time(data, true)[index] + time(data, true)[index - 1]
//               : time(data, true)[index]
//           : index > 0
//               ? time(data, false)[index] + time(data, false)[index - 1]
//               : time(data, false)[index],
//       isIncome ? incomeChartValue(data, index) : 0,
//       isIncome ? 0 : expenseChartValue(data, index),
//     );
//   });
// }



//   int incomeChartValue(List<Add_data> data, int index) {
//     return data[index].iN == 'Income' ? int.parse(data[index].amount) : 0;
//   }

//   int expenseChartValue(List<Add_data> data, int index) {
//     return data[index].iN == 'Income' ? 0 : int.parse(data[index].amount);
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales, this.income, this.expense);

//   final String year;
//   final int sales;
//   final int income;
//   final int expense;

//   int get value => income + expense;
// }
