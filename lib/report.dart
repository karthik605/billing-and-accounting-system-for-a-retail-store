import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'adminpage.dart';

void main() {
  runApp(ReportPage());
}

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InventoryReportPage(),
    );
  }
}

class InventoryReportPage extends StatefulWidget {
  @override
  _InventoryReportPageState createState() => _InventoryReportPageState();
}

class _InventoryReportPageState extends State<InventoryReportPage> {
  List<dynamic> inventory = [];
  List<dynamic> soldItems = [];

  @override
  void initState() {
    super.initState();
    fetchInventory();
    fetchSoldItems();
  }

  Future<void> fetchInventory() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/getinventory'));
    if (response.statusCode == 200) {
      setState(() {
        inventory = json.decode(response.body);
      });
    } else {
      // Handle error
    }
  }

  Future<void> fetchSoldItems() async {
    final response = await http.get(Uri.parse('http://localhost:3000/getsold'));
    if (response.statusCode == 200) {
      setState(() {
        soldItems = json.decode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Report'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Inventory:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 300, // Adjust height as needed
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 120,
                      barGroups: inventory.map((item) {
                        final itemsAvailable = item['ITEMS AVAILABLE'];
                        return BarChartGroupData(
                          x: inventory.indexOf(item),
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: itemsAvailable is String
                                  ? double.tryParse(itemsAvailable) ?? 0
                                  : itemsAvailable.toDouble(),
                              width: 16,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Sold Items:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 300, // Adjust height as needed
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 120,
                      barGroups: soldItems.map((item) {
                        final itemsSold = item['ITEMS SOLD'];
                        return BarChartGroupData(
                          x: soldItems.indexOf(item),
                          barsSpace: 4,
                          barRods: [
                            BarChartRodData(
                              toY: itemsSold is String
                                  ? double.tryParse(itemsSold) ?? 0
                                  : itemsSold.toDouble(),
                              width: 16,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
