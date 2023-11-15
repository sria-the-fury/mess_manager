import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mess_manager/Methods/Firebase/house_expenses.dart';
import 'package:uuid/uuid.dart';

class AddShoppingItems extends StatefulWidget {
  final String houseId;
  final String currentUserId;
  final bool? isEditTable;
  final List<dynamic>? shoppingList;
  const AddShoppingItems(
      {super.key,
      required this.houseId,
      required this.currentUserId,
      this.isEditTable,
      this.shoppingList});

  @override
  State<AddShoppingItems> createState() => _AddShoppingItemsState();
}

class _AddShoppingItemsState extends State<AddShoppingItems> {
  FocusNode priceNodeFocus = FocusNode();
  FocusNode nameNodeFocus = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  ScrollController tableScrollController = ScrollController();
  late List<Map<String, dynamic>> shoppingItems = [];
  // late List<bool> selected = List<bool>.generate(shoppingItems.length, (int index) => false);
  late String itemName = '';
  late String itemPrice = '';
  late int editItemIndex;
  late bool willDeleteRow = false;
  late Map<String, dynamic> editItem = {};

  getTotalPrice(items) {
    double totalPrice = 0.0;
    // looping over data array
    items.forEach((item) {
      totalPrice += item["itemPrice"];
    });

    return totalPrice;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditTable == true) {
      for (var element in widget.shoppingList!) {
        shoppingItems.add(element);
      }
    }
  }

  void scrollTop() {
    tableScrollController.animateTo(
      tableScrollController.positions.isNotEmpty
          ? tableScrollController.position.maxScrollExtent
          : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme =
        Theme.of(context).brightness.name == 'dark' ? true : false;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton.filled(
              onPressed: () {
                setState(() {
                  willDeleteRow = !willDeleteRow;
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
              ),
              icon: Icon( willDeleteRow == false ?
                Icons.remove_circle : Icons.check_circle, color: Colors.white,),
            )
          ],
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
                autofocus: widget.isEditTable == true ? false : true,
                focusNode: nameNodeFocus,
                onTap: () {
                  if (widget.isEditTable == true) {
                    scrollTop();
                  }
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
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
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.teal)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.teal)),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6 - 10),
                  labelText: 'Add Grocery Items',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
              ),
              TextFormField(
                controller: priceController,
                focusNode: priceNodeFocus,
                onChanged: (price) {
                  setState(() {
                    itemPrice = price;
                  });
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'),)
                ],
                decoration: InputDecoration(
                  suffixIcon: IconButton.filled(
                      onPressed: itemName.isNotEmpty &&
                              (itemPrice.toString().isNotEmpty &&
                                  double.parse(itemPrice) > 0) &&
                              editItem.isEmpty
                          ? () {
                              final Map<String, dynamic> item = {
                                "itemId": const Uuid().v4(),
                                "itemName": itemName,
                                "itemPrice": double.parse(itemPrice)
                              };
                              setState(() {
                                shoppingItems.add(item);
                                scrollTop();
                                itemName = '';
                                itemPrice = '';
                              });
                              nameNodeFocus.requestFocus();
                              nameController.clear();
                              priceController.clear();
                            }
                          : editItem.isNotEmpty
                              ? () {
                                  final Map<String, dynamic> editedItem = {
                                    'id': editItem['id'],
                                    'itemName': nameController.text,
                                    'itemPrice':
                                        double.parse(priceController.text)
                                  };
                                  setState(() {
                                    shoppingItems.remove(editItem);
                                    shoppingItems.insert(
                                        editItemIndex, editedItem);
                                    editItem = {};
                                    priceController.text = '';
                                    nameController.text = '';
                                  });
                                }
                              : null,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.teal.shade600,
                      ),
                      icon: Icon(
                        editItem.isNotEmpty ? Icons.edit : Icons.arrow_upward,
                      )),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.teal)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.teal)),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.4 - 10),
                  labelText: 'Price',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
              ),
            ],
          ),
        ),
        body: shoppingItems.isNotEmpty
            ? SingleChildScrollView(
                controller: tableScrollController,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: darkTheme ? Colors.black87 : Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: darkTheme ? Colors.white : Colors.black,
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: DataTable(
                          columnSpacing: 20,
                          headingRowColor:
                              MaterialStateProperty.resolveWith((states) {
                            return Colors.teal[300];
                          }),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          columns:  <DataColumn>[
                            DataColumn(
                              numeric: true,
                              label: willDeleteRow == true ?
                              const Icon(Icons.delete_forever, color: Colors.white)
                                  : const Text(
                                'SL',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const DataColumn(
                                label: Text(
                                  'Price ৳',
                                  style: TextStyle(color: Colors.black),
                                ),
                                numeric: true),
                          ],
                          rows: shoppingItems.map<DataRow>((item) {
                            return DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                // All rows will have the same selected color.
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.red;
                                }
                                // Even rows will have a grey color.

                                return null; // Use default value for other states and odd rows.
                              }),
                              cells: <DataCell>[
                                DataCell(willDeleteRow == true
                                    ? SizedBox(
                                        height: 32,
                                        width: 32,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                            onPressed: () {
                                              setState(() {
                                                shoppingItems.remove(item);
                                              });
                                            },
                                            style: IconButton.styleFrom(
                                                backgroundColor: darkTheme
                                                    ? Colors.black87
                                                    : Colors.teal.shade600,),
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: 22,
                                            )),
                                      )
                                    : Text(
                                        '${shoppingItems.indexOf(item) + 1}')),
                                DataCell(
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(item['itemName'])),
                                    showEditIcon: true, onTap: () {
                                  setState(() {
                                    editItem = item;
                                    editItemIndex = shoppingItems.indexOf(item);
                                    nameController.text = item['itemName'];
                                    priceController.text =
                                        item['itemPrice'].toString();
                                  });
                                }),
                                DataCell(
                                  Text(item['itemPrice'].toString()),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: widget.isEditTable != true
                                  ? () {
                                      HouseExpense().addDailyExpense(
                                          widget.houseId,
                                          shoppingItems,
                                          widget.currentUserId);
                                    }
                                  : widget.isEditTable == true &&
                                          !listEquals(shoppingItems,
                                              widget.shoppingList)
                                      ? () {
                                          HouseExpense().addDailyExpense(
                                              widget.houseId,
                                              shoppingItems,
                                              widget.currentUserId);
                                        }
                                      : null,
                              child: Text(widget.isEditTable != true
                                  ? 'SUBMIT'
                                  : 'UPDATE')),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Total:    ৳${getTotalPrice(shoppingItems)}',
                                style: const TextStyle(fontSize: 18),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child: Text('Add Groceries'),
              ),
      ),
    );
  }
}
