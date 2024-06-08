import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/stockManagement02.dart';

class StockIssue extends StatefulWidget {
  const StockIssue({super.key});

  @override
  State<StockIssue> createState() => _StockIssueState();
}

class _StockIssueState extends State<StockIssue> {
  bool onclicked = true;
  int? temp = 0;
  TextEditingController _editingController = TextEditingController();
  List<TextEditingController> itemNameControllers = [];
  List<TextEditingController> itemQuantityControllers = [];

  
   void addStockData() async {
    for (int i = 0; i < temp!; i++) {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('StockData').add({
        'item_name': itemNameControllers[i].text,
        'item_quantity': int.tryParse(itemQuantityControllers[i].text),
      });
      await docRef.update({'id': docRef.id});
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    for (var controller in itemNameControllers) {
      controller.dispose();
    }
    for (var controller in itemQuantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stock Allocation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total no of items",
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Card(
                          elevation: 3,
                          shadowColor: Colors.lightGreenAccent,
                          child: Container(
                            width: width * 0.2,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _editingController,
                              decoration: InputDecoration(
                                labelText: "item no",
                                labelStyle: GoogleFonts.aboreto(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        Card(
                          shape: const CircleBorder(),
                          shadowColor: Colors.lightGreen,
                          color: Colors.blue,
                          elevation: 3,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                temp = int.tryParse(_editingController.text.trim());
                                if (temp != null) {
                                  itemNameControllers = List.generate(temp!, (i) => TextEditingController());
                                  itemQuantityControllers = List.generate(temp!, (i) => TextEditingController());
                                }
                                print("Event: $onclicked, Data: $temp");
                              });
                            },
                            icon: const Icon(Icons.done, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              onclicked
                  ? Container(
                      height: height * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: temp ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              shadowColor: Colors.lightGreen,
                              child: Container(
                                height: height * 0.25,
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Item ${index + 1}:",
                                              style: GoogleFonts.aboreto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.underline),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Card(
                                            elevation: 7,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.25,
                                              child: TextFormField(
                                                controller: itemNameControllers[index],
                                                decoration: InputDecoration(
                                                  labelText: "Item name",
                                                  labelStyle: GoogleFonts.aboreto(
                                                      fontSize: 15, fontWeight: FontWeight.bold),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1, color: Colors.transparent),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: const BorderSide(width: 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            elevation: 7,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.25,
                                              child: TextFormField(
                                                controller: itemQuantityControllers[index],
                                                decoration: InputDecoration(
                                                  labelText: "Quantity",
                                                  labelStyle: GoogleFonts.aboreto(
                                                      fontSize: 15, fontWeight: FontWeight.bold),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1, color: Colors.transparent),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: const BorderSide(width: 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    if (temp != null && temp! > 0) {
                      addStockData();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const StockDetails()));
                      
                    } else {
                      print("Cannot Go in!!");
                    }
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.2,
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.aboreto(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
