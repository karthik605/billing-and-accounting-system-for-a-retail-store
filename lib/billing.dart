import 'dart:convert';
import 'package:bas/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'adminpage.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyApp(),
//   ));
// }

class Item {
  final String id;
  final String name;
  final double price;
  int quantity;
  int selectedQuantity; // Added field for selected quantity

  Item({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.selectedQuantity = 1, // Default selected quantity to 1
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supermarket Billing System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BillingPage(),
    );
  }
}

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  List<Item> inventoryItems = []; // Full inventory items
  List<Item> billedItems = []; // Items that have been billed
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/getinventory'));
      if (response.statusCode == 200) {
        final List<dynamic> itemsData = jsonDecode(response.body);
        // print(itemsData);
        setState(() {
          inventoryItems = itemsData.map((itemData) {
            return Item(
              id: itemData['ITEM ID'].toString(),
              name: itemData['ITEM NAME'],
              price: double.parse(itemData['PRICE(For item)']),
              quantity: int.parse(
                  itemData['ITEMS AVAILABLE']), // Parse quantity as int
            );
          }).toList();
        });
        print(inventoryItems[0].quantity);
      } else {
        throw Exception('Failed to fetch items');
      }
    } catch (error) {
      print('Error fetching items: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supermarket Billing System'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print(loginResult);
            if (loginResult == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginpage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printBill(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: itemIdController,
              decoration: InputDecoration(labelText: 'Item ID'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: addItem,
              child: Text('Add Item'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: billedItems.length,
                itemBuilder: (context, index) {
                  final item = billedItems[index];
                  return GestureDetector(
                    onTap: () {
                      _showItemOptions(context, item);
                    },
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                            '${item.name} - Quantity: ${item.selectedQuantity} - Total: ₹${(item.price * item.selectedQuantity).toStringAsFixed(2)}'),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Total Amount: ₹${calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void addItem() {
    final itemId = itemIdController.text;
    final quantity = int.tryParse(quantityController.text) ?? 1;
    final item = inventoryItems.firstWhere((item) => item.id == itemId,
        orElse: () => Item(id: '', name: '', price: 0.0));

    if (item.id.isNotEmpty) {
      // Check if there's enough quantity available
      if (quantity <= item.quantity) {
        // Update billed items list
        setState(() {
          final billedItemIndex =
              billedItems.indexWhere((element) => element.id == item.id);
          if (billedItemIndex != -1) {
            billedItems[billedItemIndex].selectedQuantity += quantity;
          } else {
            billedItems.add(Item(
              id: item.id,
              name: item.name,
              price: item.price,
              quantity: item.quantity,
              selectedQuantity: quantity,
            ));
          }
        });

        // Update available quantity in inventory
        setState(() {
          item.quantity -= quantity;
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Not enough quantity available!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Item not found!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showItemOptions(BuildContext context, Item item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Quantity'),
                onTap: () {
                  Navigator.pop(context);
                  _editItemQuantity(context, item);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove Item'),
                onTap: () {
                  setState(() {
                    inventoryItems.add(item);
                    billedItems.removeWhere((element) => element.id == item.id);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editItemQuantity(BuildContext context, Item item) {
    TextEditingController newQuantityController =
        TextEditingController(text: item.selectedQuantity.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Quantity'),
          content: TextField(
            controller: newQuantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'New Quantity'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                int newQuantity = int.tryParse(newQuantityController.text) ?? 1;
                setState(() {
                  item.selectedQuantity =
                      newQuantity; // Update selected quantity
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> printBillAndClearInventory() async {
    try {
      // Create a list of bill items to send to the API
      List<Map<String, dynamic>> billItems = [];
      for (final item in billedItems) {
        billItems.add({
          'ITEM ID': item.id,
          'ITEM NAME': item.name,
          'ITEMS SOLD': item.selectedQuantity,
        });
      }
      final url = Uri.parse('http://localhost:3000/print-bill');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({'billItems': billItems});
      print('Bill Items: $billItems');

      // Send the list of bill items to the API
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // If the API call is successful, clear the inventory and fetch items again
        setState(() {
          inventoryItems.clear();
          billedItems.clear();
        });
        fetchItems(); // Fetch inventory items again
        // Handle the success message here if needed
      } else {
        // If the API call fails, display an error message with response body
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to print bill. ${response.body}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error printing bill: $error');
    }
  }

  void _printBill(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Final Bill'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final item in billedItems)
                Text(
                    '${item.name} - Quantity: ${item.selectedQuantity} - Total: ₹${(item.price * item.selectedQuantity).toStringAsFixed(2)}'),
              SizedBox(height: 10.0),
              Text(
                'Total Amount: ₹${calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              printBillAndClearInventory(); // Call the new function here
              Navigator.pop(context);
            },
            child: Text('Print'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (final item in billedItems) {
      total += item.price * item.selectedQuantity;
    }
    return total;
  }
}
