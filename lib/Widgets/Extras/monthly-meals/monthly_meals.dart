import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MonthlyMeals extends StatefulWidget {
  const MonthlyMeals({super.key});

  @override
  State<MonthlyMeals> createState() => _MonthlyMealsState();
}

class _MonthlyMealsState extends State<MonthlyMeals> {
  final ScrollController verScroll = ScrollController();
  final ScrollController horScroll = ScrollController();
  final int days = 3;
  final List<Map<String, dynamic>> users = [
    {"id": 1, "name": "Jakaria"},
    {"id": 2, "name": "Mashud"},
    {"id": 3, "name": "Shahria"},
  ];

  final List<Map<String, dynamic>> docs = [
    {
      "id": 1,
      "lunchTaken": [1, 2],
      "breakfastTaken": [1, 3],
      "date": "1 July",
      "guestLunchMeals" : [
        {
          "id": 1,
          "meal":1
        }
      ],
      "guestBreakfast" : [
        {
          "id": 2,
          "meal":1
        }
      ],
    },
    {
      "id": 2,
      "lunchTaken": [2, 3],
      "breakfastTaken": [1, 2],
      "date": "2 July",
      "guestLunchMeals" : [
        {
          "id": 1,
          "meal":1
        }
      ],
      "guestBreakfast" : [
        {
          "id": 2,
          "meal":1
        }
      ],
    },
    {
      "id": 3,
      "lunchTaken": [2, 3],
      "breakfastTaken": [1, 2],
      "guestLunchMeals" : [
        {
          "id": 1,
          "meal":1
        }
      ],
      "guestBreakfast" : [
        {
          "id": 2,
          "meal":1
        }
      ],
      "date": "3 July",
    },
    {
      "id": 3,
      "lunchTaken": [2, 3],
      "breakfastTaken": [1, 2],
      "guestLunchMeals" : [
        {
          "id": 1,
          "meal":1
        }
      ],
      "guestBreakfast" : [
        {
          "id": 2,
          "meal":1
        }
      ],
      "date": "4 July",
    },
  ];
  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
  countGuestMeal(meals, userId){
    late int totalGuestMeal = 0;
    for(var meal in meals){
      final getGuestLunch = meal['guestLunchMeals'].where((lunch) => lunch['id'] == userId);
      final getGuestBreakfast = meal['guestBreakfast'].where((breakfast) => breakfast['id'] == userId);
      if(getGuestLunch.isNotEmpty){
        totalGuestMeal = totalGuestMeal + 1;
      }
      if(getGuestBreakfast.isNotEmpty){
        totalGuestMeal = totalGuestMeal + 1;
      }
    }

    return totalGuestMeal;

  }

  countTotalMeals(meals, userId){
    late int totalMeals = 0;
    for(var meal in meals){
      if(meal['lunchTaken'].contains(userId)){
        totalMeals = totalMeals + 1 ;
      }
      if(meal['breakfastTaken'].contains(userId)){
        totalMeals = totalMeals + 1 ;
      }

    }
    return totalMeals;

  }
  countGrandTotal(meals,users){
    late int grandTotal = 0;
    for(var user in users){
     final int totalMeals = countGuestMeal(meals, user['id']) + countTotalMeals(meals, user['id']);
     grandTotal = grandTotal + totalMeals;
    }
    return grandTotal;
    
  }
   DataRow getMeals(user) {

    return DataRow(cells: <DataCell>[
      DataCell(Text(user['name'])),
      const DataCell(Column(
        children: [
          Text('B'),
          Text('L'),
        ],
      )),
      for (var doc in docs)
        DataCell(Column(
          children: [
            Text(doc['breakfastTaken'].contains(user['id']) ? '1' : '-'),
            Text(doc['lunchTaken'].contains(user['id']) ? '1' : '-'),
          ],
        )),
      DataCell(Text(countGuestMeal(docs, user['id']).toString())),
      DataCell(Text('${countTotalMeals(docs, user['id'])} '
          '+ ${countGuestMeal(docs, user['id'])} = ${countTotalMeals(docs, user['id']) + countGuestMeal(docs, user['id'])}'))
    ]);
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );

  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp],
    );

  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    debugPrint('guest meals => ${countGrandTotal(docs,users)}');
    return Scaffold(
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(5),
      //   decoration: BoxDecoration(
      //     color: Colors.teal.shade500,
      //     borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight:Radius.circular(10))
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       const Text('Grand Total', style: TextStyle(fontSize: 16),),
      //       Text('Σ ${countGrandTotal(docs,users)}', style: const TextStyle(fontSize: 16),)
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: const Text('MONTHLY - JUNE 2023'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: darkTheme ? Colors.black : Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10)
        ),


        child: Scrollbar(
          controller: verScroll,
          trackVisibility: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: verScroll,
            child: SizedBox(
              child: Scrollbar(
                trackVisibility: true,
                controller: horScroll,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: horScroll,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      showBottomBorder: true,
                      columnSpacing: 5,
                      headingRowColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.teal[300];
                      }),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      columns: <DataColumn>[
                        const DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'Meals',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        for (int d = 1; d <= docs.length; d++)
                          DataColumn(
                              label: Text(
                                '$d',
                                style: const TextStyle(color: Colors.black),
                              ),
                              numeric: true),
                        const DataColumn(
                          numeric: true,
                          label: Text(
                            'Guest',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const DataColumn(
                          numeric: true,
                          label: Text(
                            'Total',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                      ],
                        rows: users.map((user)=> getMeals(user)).toList()
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
