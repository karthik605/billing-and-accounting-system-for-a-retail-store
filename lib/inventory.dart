import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: InventoryPage(),
//   ));
// }

class InventoryPage extends StatelessWidget {
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemsAvailableController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController updateItemIdController = TextEditingController();
  final TextEditingController updatedQuantityController =
      TextEditingController();

  Future<void> addInventory(BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/addinventory');
    List<Map<String, dynamic>> AddItems = [];
    AddItems.add({
      'ITEM ID': itemIdController.text,
      'ITEM NAME': itemNameController.text,
      'ITEMS AVAILABLE': itemsAvailableController.text,
      'PRICE(For item)': priceController.text
    });
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'AddItems': AddItems});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Successful request, handle accordingly
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Inventory added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Inventory added successfully');
    } else {
      // Request failed, handle error
      print('Failed to add inventory. Error: ${response.body}');
    }
  }

  Future<void> updateInventory(BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/updateinventory');
    List<Map<String, dynamic>> UpdateItems = [];
    UpdateItems.add({
      'ITEM ID': updateItemIdController.text,
      'ITEMS AVAILABLE': updatedQuantityController.text,
    });
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'UpdateItems': UpdateItems});
    final response = await http.patch(url, headers: headers, body: body);
    // final url = Uri.parse('http://localhost:3000/updateinventory');
    // final response = await http.patch(
    //   url,
    //   body: {
    //     'itemId': updateItemIdController.text,
    //     'quantity': updatedQuantityController.text,
    //   },
    // );

    if (response.statusCode == 200) {
      // Successful request, handle accordingly
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Inventory updated successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Inventory updated successfully');
    } else {
      // Request failed, handle error
      print('Failed to update inventory. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Inventory',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: itemIdController,
              decoration: InputDecoration(labelText: 'Item ID'),
            ),
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: itemsAvailableController,
              decoration: InputDecoration(labelText: 'Items Available'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                await addInventory(context);
              },
              child: Text('Add'),
            ),
            SizedBox(height: 20),
            Text(
              'Update Inventory',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: updateItemIdController,
              decoration: InputDecoration(labelText: 'Item ID to Update'),
            ),
            TextField(
              controller: updatedQuantityController,
              decoration: InputDecoration(labelText: 'Updated Quantity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => updateInventory(context),
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
