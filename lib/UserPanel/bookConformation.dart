import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newdigiration/UserPanel/thankyou.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookConfirmation extends StatefulWidget {
  final DateTime bookingDate;
  final int selectedIndex;
  final String gmail;

  const BookConfirmation(
      {super.key,
      required this.bookingDate,
      required this.selectedIndex,
      required this.gmail});

  @override
  State<BookConfirmation> createState() => BookConfirmationState();
}

class BookConfirmationState extends State<BookConfirmation> {
  var data;
  var SlotStartTime;
  var SlotEndTime;
  var Slot;

  void checkBookings() {
    if (widget.selectedIndex == 0) {
      data = "8:00 AM - 9:00 AM";
      SlotStartTime = "8:00 AM";
      SlotEndTime = "9:00 AM";
      Slot = "Morning";
    } else if (widget.selectedIndex == 1) {
      data = "10:30 AM - 11:30 AM";
      SlotStartTime = "10:30 AM";
      SlotEndTime = "11:30 AM";
      Slot = "Morning";
    } else if (widget.selectedIndex == 2) {
      data = "3:00 PM - 4:00 PM";
      SlotStartTime = "3:00 PM";
      SlotEndTime = "4:00 PM";
      Slot = "Evening";
    } else if (widget.selectedIndex == 3) {
      data = "5:30 PM - 6:30 PM";
      SlotStartTime = "5:30 PM";
      SlotEndTime = "6:30 PM";
      Slot = "Evening";
    }
  }

  bool isActive = false;
  void ontapchange() {
    print('Before$isActive');
    setState(() {
      isActive = true;
      checkstak();
      updateStockQuantities();
      print('After$isActive');
    });
  }
  

  // total Quantity of rice, wheat, sugar, oil
  int totalRiceQuantity = 0;
  int totalWheatQuantity = 0;
  int totalSugarQuantity = 0;
  int totalOilQuantity = 0;

  void checkstak(){
    if (totalOilQuantity < 4 ||
                      totalRiceQuantity < 4 ||
                      totalWheatQuantity < 4 ||
                      totalSugarQuantity < 4) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Insufficient Stock',
                            style: GoogleFonts.abel(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Try Again Later',
                            style: GoogleFonts.abel(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ok',
                                  style: GoogleFonts.abel(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ))
                          ],
                        );
                      },
                    );
                  } else {
                    addUserSlot();
                  }
  }

  Future<void> updateStockQuantities() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('StockData').get();

    for (var doc in snapshot.docs) {
      var itemName = doc['item_name'];
      var itemQuantity = int.tryParse(doc['item_quantity'].toString()) ?? 0;

      if (itemName == 'rice') {
        totalRiceQuantity = itemQuantity - 4;
        if (totalRiceQuantity < 0) totalRiceQuantity = 0;
      } else if (itemName == 'wheat') {
        totalWheatQuantity = itemQuantity - 4;
        if (totalWheatQuantity < 0) totalWheatQuantity = 0;
      } else if (itemName == 'sugar') {
        totalSugarQuantity = itemQuantity - 4;
        if (totalSugarQuantity < 0) totalSugarQuantity = 0;
      } else if (itemName == 'oil') {
        totalOilQuantity = itemQuantity - 4;
        if (totalOilQuantity < 0) totalOilQuantity = 0;
      }

      await FirebaseFirestore.instance.collection('StockData').doc(doc.id).update({
        'item_quantity': itemName == 'rice' ? totalRiceQuantity :
                          itemName == 'wheat' ? totalWheatQuantity :
                          itemName == 'sugar' ? totalSugarQuantity :
                          totalOilQuantity
      });
    }

    print("Rice: $totalRiceQuantity, Wheat: $totalWheatQuantity, Sugar: $totalSugarQuantity, Oil: $totalOilQuantity");
  }

  void addUserSlot() async {
    await FirebaseFirestore.instance.collection('UserSlot').add({
      'gmail': widget.gmail,
      'slot': Slot,
      'slotStarttime': SlotStartTime,
      'slotEndtime': SlotEndTime,
      'Date': DateTime.now().toString()
    }).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  const ThankyouPage()));
    });
  }

  // getting the gmail of the current logged in user
  static const KEY_EMAIL = "email";
  static const KEY_BUTTON = "button";
  // one time button click logic
  // Initialize the value to false
  var buttonClicked;

  // Function to disable the button and set the value to true
  void disableButton() async {
    var sharedpref = await SharedPreferences.getInstance();
    setState(() {
      sharedpref.setBool(KEY_BUTTON, true);
      buttonClicked = sharedpref.getBool(KEY_BUTTON);
    });
  }

  getGmail() async {
    var sharedpref = await SharedPreferences.getInstance();
    var email = sharedpref.getString(KEY_EMAIL);
    return email;
  }

  int MycurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkBookings();
    updateStockQuantities();
    // getTotalQuantityOfOil();
    // getTotalQuantityOfRice();
    // getTotalQuantityOfWheat();
    // getTotalQuantityOfSugar();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: const Text(
          "DIGI-RATION",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 20,
              backgroundImage: AssetImage("images/user.jpg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.calendar_month_sharp,
                size: 65,
                color: Colors.lightBlue.shade200,
                shadows: const [
                  Shadow(
                      color: Colors.greenAccent,
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Book Slot",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: height * 0.09,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Slot Details:",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: Colors.greenAccent),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Selected Date: ${DateFormat.yMEd().format(widget.bookingDate)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Selected Time: ${widget.selectedIndex == 0 ? data : (widget.selectedIndex == 1) ? data : (widget.selectedIndex == 2) ? data : (widget.selectedIndex == 3) ? data : (widget.selectedIndex == 4) ? data : null}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade800,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Edit Slot",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              GestureDetector(
                // Updated onTap handler
                onTap: () async {
                  ontapchange();
                  
                },
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade800,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Confirm Slot",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
