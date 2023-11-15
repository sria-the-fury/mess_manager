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
      if(houseController.houseYesterdayExpense.isEmpty && houseController.houseTodayExpense.isEmpty){
        return const Center(
          child: Text('No shopping within two days.'),
        );
      }
             return SingleChildScrollView(
                child: Column(
                  children: [
                    houseController.houseYesterdayExpense.isNotEmpty ? Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          const Text('Yesterday', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: darkTheme ? Colors.white : Colors.black,  width: 1),

                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: DataTable(
                              columnSpacing: 20,
                              headingRowColor: MaterialStateProperty.resolveWith((states) {
                                return Colors.teal[300];
                              }),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)

                              ),

                              columns:  const <DataColumn>[
                                DataColumn(
                                  numeric: true,
                                  label: Text('SL',style: TextStyle(color: Colors.black),),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text('Name',style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                                DataColumn(
                                    label: Text('Price ৳', style: TextStyle(color: Colors.black),),
                                    numeric: true
                                ),

                              ],
                              rows: houseController.houseYesterdayExpense['shoppingItems'].map<DataRow>((item) {


                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('${houseController.houseYesterdayExpense['shoppingItems'].indexOf(item) + 1}')),
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.horizontal ,

                                        child: Text(item['itemName'])),),
                                    DataCell(Text(item['itemPrice'].toString()), ),

                                  ],
                                );}).toList(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: darkTheme ? Colors.white : Colors.black,  width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Text('Total:    ৳${getTotalPrice(houseController.houseYesterdayExpense['shoppingItems'])}',
                                    style: const TextStyle(fontSize: 18),)),
                            ],
                          )
                        ],
                      ),
                    ) :
                    const SizedBox(),
                    houseController.houseTodayExpense.isNotEmpty ? Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          const Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          const SizedBox(height: 10,),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: darkTheme ? Colors.white : Colors.black,  width: 1),

                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: DataTable(
                              columnSpacing: 20,
                              headingRowColor: MaterialStateProperty.resolveWith((states) {
                                return Colors.teal[300];
                              }),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)

                              ),

                              columns:  const <DataColumn>[
                                DataColumn(
                                  numeric: true,
                                  label: Text('SL',style: TextStyle(color: Colors.black),),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text('Name',style: TextStyle(color: Colors.black),),
                                  ),
                                ),
                                DataColumn(
                                    label: Text('Price ৳', style: TextStyle(color: Colors.black),),
                                    numeric: true
                                ),
                              ],
                              rows: houseController.houseTodayExpense['shoppingItems'].map<DataRow>((item) {


                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('${houseController.houseTodayExpense['shoppingItems'].indexOf(item) + 1}')),
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.horizontal ,

                                        child: Text(item['itemName'])),),
                                    DataCell(Text(item['itemPrice'].toString()), ),

                                  ],
                                );}).toList(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: houseController.houseTodayExpense['addedBy'] == currentUser.uid
                                ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                            children: [
                              if(houseController.houseTodayExpense['addedBy'] == currentUser.uid)
                                TextButton(onPressed: (){
                                Get.to(() => AddShoppingItems(houseId: houseController.houseData['houseId'],
                                  currentUserId: currentUser.uid,isEditTable: true,
                                  shoppingList:
                                  houseController.houseTodayExpense['shoppingItems'],
                                ),
                                    transition: Transition.downToUp);

                              },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.teal[600],
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.edit, color: Colors.white, size: 16,),
                                          SizedBox(width: 5,),
                                          Text('EDIT', style: TextStyle(color: Colors.white),),
                                        ],
                                      ))),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: darkTheme ? Colors.white : Colors.black,  width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),

                                  child: Text('Total:    ৳${getTotalPrice(houseController.houseTodayExpense['shoppingItems'])}',
                                    style: const TextStyle(fontSize: 18),)),
                            ],
                          )
                        ],
                      ),
                    ) :
                    const Center(child: Text('No shopping for today')),
                  ],
                ),
              );}
      ),
      floatingActionButton: Obx((){
        if(houseController.houseData.isNotEmpty){

          if(houseController.houseData['houseManager'] == currentUser.uid
    && houseController.houseTodayExpense.isEmpty){
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

