import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mess_manager/Methods/Controller/firestore_controller.dart';
import 'package:mess_manager/Widgets/Extras/add_shopping_items.dart';

class Expenses extends StatelessWidget {
  final FirestoreController houseController = Get.put(FirestoreController());
  Expenses({super.key});

  @override
  Widget build(BuildContext context) {

    getTotalPrice(items){
      double totalPrice = 0.0;
      // looping over data array
      items.forEach((item){
        totalPrice += item["itemPrice"];
      });

      return totalPrice;
    }

    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;

    User? currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}
              , icon: const Icon(Icons.calendar_view_month))
        ], 
        surfaceTintColor: Colors.transparent,
        title: const Text('EXPENSES'),
      ),
      body: Obx((){
        if(houseController.houseExpense.isEmpty){
          return const Center(child: Text('Add Groceries'),);
        }
        else{
          final day = DateTime.now().day;
          final previousDay = DateTime.now().subtract(const Duration(days: 1)).day;
          final month = DateTime.now().month;
          final year = DateTime.now().year;
          final todayShopping = houseController.houseExpense.where((items) =>
              items['id'] == '$day$month$year'
          );
          final yesterdayShopping = houseController.houseExpense.where((items) =>
          items['id'] == '$previousDay$month$year'
          );
            return
              SingleChildScrollView(
                child: Column(
                  children: [
                    todayShopping.isNotEmpty ? Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          const Text('Today', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(

                              showBottomBorder: true,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Price ৳', textAlign: TextAlign.right,
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),

                              ],
                              rows: todayShopping.first['shoppingItems'].map<DataRow>((item) {

                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.horizontal ,

                                        child: Text(item['itemName']))),
                                    DataCell(Text(item['itemPrice'].toString())),
                                  ],
                                );}).toList(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.teal[500],
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Text('Total:    ৳${getTotalPrice(todayShopping.first['shoppingItems'])}',
                                    style: const TextStyle(fontSize: 18, color: Colors.white),))
                            ],
                          )
                        ],
                      ),
                    ) :
                    const Center(child: Text('No shopping for today')),
                    yesterdayShopping.isNotEmpty ? Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          const Text('Yesterday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(

                              showBottomBorder: true,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Price ৳',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),

                              ],
                              rows: yesterdayShopping.first['shoppingItems'].map<DataRow>((item) {

                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.horizontal ,

                                        child: Text(item['itemName']))),
                                    DataCell(Text(item['itemPrice'].toString())),
                                  ],
                                );}).toList(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.teal[500],
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Text('Total:    ৳${getTotalPrice(yesterdayShopping.first['shoppingItems'])}',
                                    style: const TextStyle(fontSize: 18, color: Colors.white),))
                            ],
                          )
                        ],
                      ),
                    ) :
                    const Center(child: Text('No shopping for yesterday.')),
                  ],
                ),
              );

          }
      }),
      floatingActionButton: Obx((){
        if(houseController.houseData.isNotEmpty){
          final day = DateTime.now().day;

          final month = DateTime.now().month;
          final year = DateTime.now().year;
          final todayShopping = houseController.houseExpense.where((items) =>
          items['id'] == '$day$month$year'
          );

          if(houseController.houseData['houseManager'] == currentUser.uid && todayShopping.isEmpty){
            return FloatingActionButton(onPressed: (){
              Get.to( () => AddShoppingItems(houseId: houseController.houseData['houseId'],
                  currentUserId: currentUser.uid),
                  transition: Transition.downToUp);
            },
                child: const Icon(Icons.shopping_bag, color: Colors.white,));
          }
          return const SizedBox();
        }
        return const SizedBox();
      })
    );
  }
}

