// showing pie chart in all categories....

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:finance_tracker/db/add_date.dart';
// import 'package:finance_tracker/data/chart.dart';
// import 'package:finance_tracker/data/utility.dart';

// class GraphicalPage extends StatefulWidget {
//   const GraphicalPage({super.key});

//   @override
//   State<GraphicalPage> createState() => _GraphicalPageState();
// }

// ValueNotifier kj = ValueNotifier(0);

// class _GraphicalPageState extends State<GraphicalPage> {
//   Color mycolor = const Color.fromARGB(255, 18, 54, 52);
//   List day = ['Day', 'Week', 'Month', 'Year'];
//   List f = [today(), week(), month(), year()];
//   List<Add_data> a = [];
//   int index_color = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ValueListenableBuilder(
//           valueListenable: kj,
//           builder: (context, dynamic value, Widget? child) {
//             a = f[
//                 value]; // Get the current data for the selected day/week/month/year
//             return custom();
//           },
//         ),
//       ),
//     );
//   }

//   CustomScrollView custom() {
//     return CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Statistics',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ...List.generate(4, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             index_color = index;
//                             kj.value = index;
//                           });
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 80,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: index_color == index
//                                   ? mycolor
//                                   : Colors.white),
//                           alignment: Alignment.center,
//                           child: Text(
//                             day[index],
//                             style: TextStyle(
//                                 color: index_color == index
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       );
//                     })
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               // Pie Chart Section
//               SizedBox(
//                 height: 250, // Adjust the height as per your design
//                 child: PieChart(
//                   PieChartData(
//                     sections: a
//                         .map((data) => PieChartSectionData(
//                               value: double.parse(
//                                   data.amount), // Expense amount from the list
//                               color: getRandomColor(),
//                               title: data.name, // Expense name from the list
//                               radius: 50,
//                               titleStyle: const TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.bold),
//                             ))
//                         .toList(),
//                     sectionsSpace: 5,
//                     centerSpaceRadius: 40,
//                     borderData: FlBorderData(show: true),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Top Spending',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold)),
//                     Icon(
//                       Icons.swap_vert,
//                       size: 25,
//                       color: Colors.grey,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               return ListTile(
//                 leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(13),
//                     child: Image.asset('asset/image/${a[index].name}.png')),
//                 title: Text(
//                   a[index].name,
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   '${a[index].datetime.day}-${a[index].datetime.month}-${a[index].datetime.year}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 trailing: Text(
//                   '₹${a[index].amount}',
//                   style: TextStyle(
//                       color:
//                           a[index].iN == 'Income' ? Colors.green : Colors.red,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               );
//             },
//             childCount: a.length,
//           ),
//         )
//       ],
//     );
//   }

//   // Function to generate random colors for the pie chart sections
//   Color getRandomColor() {
//     List<Color> pieColors = [
//       Colors.blue,
//       Colors.green,
//       Colors.red,
//       Colors.orange,
//       Colors.purple,
//       Colors.yellow,
//     ];
//     pieColors.shuffle();
//     return pieColors.first;
//   }
// }
