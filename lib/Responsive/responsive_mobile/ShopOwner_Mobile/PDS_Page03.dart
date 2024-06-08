import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/Dasboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PDS03 extends StatefulWidget {
  const PDS03({super.key});

  @override
  State<PDS03> createState() => _PDS03State();
}

class _PDS03State extends State<PDS03> {
  bool onclicked = true;
  int? temp = 0;
  TextEditingController _editingController = TextEditingController();
  // Controllers for text fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          'PDS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
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
                      "Total Family Members",
                      style: GoogleFonts.abhayaLibre(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Card(
                          elevation: 3,
                          shadowColor: Colors.lightGreenAccent,
                          child: Container(
                            height: height * 0.06,
                            width: width * 0.2,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _editingController,
                              decoration: InputDecoration(
                                labelText: "data",
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
                                // onclicked = !onclicked;
                                temp =
                                    int.tryParse(_editingController.text.trim());
                                print("Event :$onclicked , Data :${temp}");
                              });
                            },
                            icon: const Icon(Icons.done, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // ListView
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
                                height: height * 0.33,
                                width: width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Member ${index + 1}:",
                                              style: GoogleFonts.aboreto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Card(
                                            elevation: 7,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.25,
                                              child: TextFormField(
                                                controller: firstNameController,
                                                decoration: InputDecoration(
                                                  labelText: "First name",
                                                  labelStyle: GoogleFonts.aboreto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1),
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
                                                controller: middleNameController,
                                                decoration: InputDecoration(
                                                  labelText: "Middle name",
                                                  labelStyle: GoogleFonts.aboreto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1),
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
                                                controller: lastNameController,
                                                decoration: InputDecoration(
                                                  labelText: "Last name",
                                                  labelStyle: GoogleFonts.aboreto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    borderSide: const BorderSide(
                                                        width: 1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Card(
                                              elevation: 7,
                                              shadowColor: Colors.black,
                                              color: Colors.white,
                                              child: Container(
                                                height: height * 0.06,
                                                width: width * 0.2,
                                                child: TextFormField(
                                                  controller: ageController,
                                                  decoration: InputDecoration(
                                                    labelText: "Age",
                                                    labelStyle:
                                                        GoogleFonts.aboreto(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Colors
                                                                  .transparent),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1),
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
                                                width: width * 0.45,
                                                child: TextFormField(
                                                  controller: relationController,
                                                  decoration: InputDecoration(
                                                    labelText: "Relation",
                                                    labelStyle:
                                                        GoogleFonts.aboreto(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Colors
                                                                  .transparent),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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

              //
              Card(
                elevation: 3,
                color: Colors.blueGrey,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Back",
                          style: GoogleFonts.aboreto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (temp! > 0) {
                            // Call function to add data to Firestore
                            addBeneficiaryData();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                          }
                          print("Cannot Go in!!");
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          child: Center(
                              child: Text("Submit",
                                  style: GoogleFonts.aboreto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to add data to Firestore
  void addBeneficiaryData() {
    for (int i = 0; i < temp!; i++) {
      FirebaseFirestore.instance.collection("beneficiary03").add({
        'firstName': firstNameController.text.trim(),
        'middleName': middleNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'age': ageController.text.trim(),
        'relation': relationController.text.trim(),
      });
    }
  }
}
