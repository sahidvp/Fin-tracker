import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:finance_tracker/db/add_date.dart';
import 'package:finance_tracker/data/chart.dart';
import 'package:finance_tracker/data/utility.dart';

class GraphicalPage extends StatefulWidget {
  const GraphicalPage({super.key});

  @override
  State<GraphicalPage> createState() => _GraphicalPageState();
}

ValueNotifier kj = ValueNotifier(0);

class _GraphicalPageState extends State<GraphicalPage> {
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (context, dynamic value, Widget? child) {
            a = f[value]; // Get the current data for the selected day/week/month/year
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    // Summing up Income and Expense amounts
    double totalIncome = 0;
    double totalExpense = 0;

    for (var data in a) {
      if (data.iN == 'Income') {
        totalIncome += double.parse(data.amount);
      } else if (data.iN == 'Expense') {
        totalExpense += double.parse(data.amount);
      }
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Statistics',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            index_color = index;
                            kj.value = index;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index_color == index
                                  ? mycolor
                                  : Colors.white),
                          alignment: Alignment.center,
                          child: Text(
                            day[index],
                            style: TextStyle(
                                color: index_color == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Pie Chart Section showing only Income and Expense
              SizedBox(
                height: 250, // Adjust the height as per your design
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: totalIncome, // Total Income
                        color: Colors.green, // Green for income
                        title: 'Income',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        value: totalExpense, // Total Expense
                        color: Colors.red, // Red for expense
                        title: 'Expense',
                        radius: 50,
                        titleStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                    sectionsSpace: 5,
                    centerSpaceRadius: 40,
                    borderData: FlBorderData(show: true),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Spending',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.asset('asset/image/${a[index].name}.png')),
                title: Text(
                  a[index].name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${a[index].datetime.day}-${a[index].datetime.month}-${a[index].datetime.year}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Text(
                  '₹${a[index].amount}',
                  style: TextStyle(
                      color:
                          a[index].iN == 'Income' ? Colors.green : Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
            childCount: a.length,
          ),
        )
      ],
    );
  }
}
