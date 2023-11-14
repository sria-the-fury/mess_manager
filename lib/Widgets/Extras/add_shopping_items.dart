import 'package:flutter/material.dart';
import 'package:mess_manager/Methods/Firebase/house_expenses.dart';
import 'package:uuid/uuid.dart';

class AddShoppingItems extends StatefulWidget {
  final String houseId;
  final String currentUserId;
  const AddShoppingItems({super.key, required this.houseId, required this.currentUserId});

  @override
  State<AddShoppingItems> createState() => _AddShoppingItemsState();
}

class _AddShoppingItemsState extends State<AddShoppingItems> {
  FocusNode priceNodeFocus = FocusNode();
  FocusNode nameNodeFocus = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  late List<Map<String, dynamic>> shoppingItems = [];
  late String itemName = '';
  late String itemPrice = '';

  getTotalPrice(items){
    double totalPrice = 0.0;
    // looping over data array
    items.forEach((item){
      totalPrice += item["itemPrice"];
    });

    return totalPrice;
  }



  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness.name == 'dark' ? true : false;
    debugPrint('shoppingItems => $shoppingItems');
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('ADD SHOPPING'),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                autofocus: true,
                focusNode: nameNodeFocus,
                onFieldSubmitted: (value){
                  if(value.isNotEmpty){
                    priceNodeFocus.requestFocus();
                  }
                },
                onChanged: (name) {
                  setState(() {
                    itemName = name;
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25) ),
                      borderSide: BorderSide(color: Colors.teal)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25) ),
                      borderSide: BorderSide(color: Colors.teal)),

                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6-10
                  ),
                  labelText: 'Add Grocery Items',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
              ),
              TextFormField(
                controller: priceController,
                focusNode: priceNodeFocus,
                onChanged: (price) {
                  setState(() {
                    itemPrice =price;
                  });
                },

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: IconButton.filled(onPressed: itemName.isNotEmpty
                      && (itemPrice.toString().isNotEmpty && double.parse(itemPrice) > 0) ? (){
                    final Map<String, dynamic> item = {
                      "itemId": const Uuid().v4(),
                      "itemName": itemName,
                      "itemPrice": double.parse(itemPrice)
                    };
                    setState(() {
                      shoppingItems.add(item);
                      itemName = '';
                      itemPrice = '';
                    });
                    nameNodeFocus.requestFocus();
                    nameController.clear();
                    priceController.clear();

                  } : null,
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.teal.shade600,),
                      icon: const Icon(Icons.arrow_upward, color: Colors.white,)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25) ),
                      borderSide: BorderSide(color: Colors.teal)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25) ),
                      borderSide: BorderSide(color: Colors.teal)),

                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4-10
                  ),
                  labelText: 'Price',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
              ),


            ],
          ),
        ),
        body: shoppingItems.isNotEmpty ?
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkTheme ? Colors.black87 : Colors.teal.shade100,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
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
                      DataColumn(
                        label: SizedBox(
                          width: 40,
                          child: Text(
                            'Actions',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),

                    ],
                    rows: shoppingItems.map<DataRow>((item) {
                      final itemLength = shoppingItems.length;

                      return DataRow(
                      cells: <DataCell>[
                        DataCell(SingleChildScrollView(
                          scrollDirection: Axis.horizontal ,

                            child: Text(item['itemName']))),
                        DataCell(Text(item['itemPrice'].toString())),
                        DataCell(SizedBox(
                          height: 32,
                          width: 32,
                          child: IconButton(
                              onPressed: (){
                                setState(() {
                                  shoppingItems.remove(item);
                                });

                          },
                          style: IconButton.styleFrom(
                            backgroundColor: darkTheme
                                ? Colors.black87
                                : Colors.teal.shade600,
                            side: const BorderSide(
                                color: Colors.white, width: 2)),
                              icon: const Icon(Icons.remove_circle, size: 16,)),
                        ))
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

                        child: Text('Total:    ৳${getTotalPrice(shoppingItems)}',
                          style: const TextStyle(fontSize: 18, color: Colors.white),)),
                    TextButton(onPressed: (){
                      HouseExpense().addDailyExpense(widget.houseId, shoppingItems, widget.currentUserId);
                    },
                        child: const Text('Submit'))
                  ],
                )
              ],
            ),
          ),
        ) : const Center(child: Text('Add Groceries'),),
      ),
    );
  }
}
