import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({super.key});

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  Future<List<Map<String, dynamic>>> fetchStockData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('StockData').get();
    return snapshot.docs.map((doc) => {
      'item_name': doc['item_name'] as String,
      'item_quantity': doc['item_quantity'].toString(), 
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'Stock Details and Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30,),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchStockData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No stock data found.');
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text('Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                          ],
                          rows: snapshot.data!.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['item_name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
                              DataCell(Text(data['item_quantity'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
