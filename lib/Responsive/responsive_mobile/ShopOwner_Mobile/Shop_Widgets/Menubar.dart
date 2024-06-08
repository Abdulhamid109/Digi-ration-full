import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/DBModal/UserModal.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/PDS_Page01.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/ShopOwnerLoginMobile.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/analysis&rep.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/complaint_page.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/feedback_page.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/slot_management.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/stockManagement01.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/stockManagement02.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/viewCustomer.dart';

class MenuBarr extends StatefulWidget {
  const MenuBarr({super.key});

  @override
  State<MenuBarr> createState() => _MenuBarrState();
}

class _MenuBarrState extends State<MenuBarr> {
  Future<UserData> getCurrentShopUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the current user
    User? user = auth.currentUser;

    if (user != null) {
      // Get the document corresponding to the user from Firestore
      DocumentSnapshot snapshot =
          await firestore.collection('ShopOwnerUsers').doc(user.uid).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Convert the data from Firestore to your UserData model
        UserData userData =
            UserData.fromMap(snapshot.data() as Map<String, dynamic>);
        return userData;
      } else {
        // Document doesn't exist
        throw Exception('User data not found');
      }
    } else {
      // No user signed in
      throw Exception('No user signed in');
    }
  }

  //total Quantity of rice wheat sugar oil
  int totalRiceQuantity = 0;
  Future getTotalQuantityOfRice() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('StockData').get();

    for (var doc in snapshot.docs) {
      if (doc['item_name'] == 'rice') {
        totalRiceQuantity += int.tryParse(doc['item_quantity'].toString()) ?? 0;
      }
    }

    // return totalRiceQuantity;
  }

  int totalWheatQuantity = 0;
  Future getTotalQuantityOfWheat() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('StockData').get();

    for (var doc in snapshot.docs) {
      if (doc['item_name'] == 'wheat') {
        totalWheatQuantity +=
            int.tryParse(doc['item_quantity'].toString()) ?? 0;
      }
    }

    // return totalWheatQuantity;
  }

  int totalSugarQuantity = 0;
  Future getTotalQuantityOfSugar() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('StockData').get();

    for (var doc in snapshot.docs) {
      if (doc['item_name'] == 'sugar') {
        totalSugarQuantity +=
            int.tryParse(doc['item_quantity'].toString()) ?? 0;
      }
    }
    print(totalSugarQuantity);

    // return totalSugarQuantity;
  }

  int totalOilQuantity = 0;
  Future getTotalQuantityOfOil() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('StockData').get();

    for (var doc in snapshot.docs) {
      if (doc['item_name'] == 'oil') {
        totalOilQuantity += int.tryParse(doc['item_quantity'].toString()) ?? 0;
      }
    }
    print(totalOilQuantity);
    // return totalOilQuantity;
  }

  //SignOut
  firebaseSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ShopOwnerLoginMobile()));
    } on FirebaseAuthException catch (exp) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                exp.code.toString(),
                style: GoogleFonts.sacramento(
                    fontSize: 10, fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.sacramento(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalQuantityOfOil();
                  getTotalQuantityOfRice();
                  getTotalQuantityOfWheat();
                  getTotalQuantityOfSugar();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Colors.lightGreenAccent,
      child: Container(
        color: Colors.lightGreenAccent,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 40,
                    backgroundImage: AssetImage("images/user.jpg"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: FutureBuilder<UserData>(
                      future: getCurrentShopUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('loading...');
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Text(
                              "${snapshot.data!.FirstName} ${snapshot.data!.LastName}");
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // const ListTile(
            //   leading: CircleAvatar(
            //     backgroundColor: Colors.black54,
            //     radius: 20,
            //     backgroundImage: AssetImage("images/user.jpg"),
            //   ),
            //   title: Text(
            //     "Profile",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen())),
            // ),
            
            ListTile(
              leading: const Icon(
                Icons.file_copy,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Report Generation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Analysiss())),
            ),
             ListTile(
              leading: const Icon(
                Icons.person_add,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "New Customer",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>const PDS01())),
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const PDS01())),
            ),
             ListTile(
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "View Customer",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserListPage())),
            ),
            ListTile(
                leading: const Icon(
                  Icons.stacked_bar_chart,
                  size: 35,
                  color: Colors.white,
                ),
                title: const Text(
                  "Stock Management",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  
                  if (totalOilQuantity <= 0 ||
                      totalRiceQuantity <= 0 ||
                      totalWheatQuantity <= 0 ||
                      totalSugarQuantity <= 0) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Stock Alert",
                              style: GoogleFonts.abel(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add Stock',
                                      style: GoogleFonts.abel(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text('Rice:$totalRiceQuantity'),
                                Text('Wheat:$totalWheatQuantity'),
                                Text('Oil:$totalOilQuantity'),
                                Text('Sugar:$totalSugarQuantity'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StockIssue()));
                                  },
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.abel(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "cancel",
                                    style: GoogleFonts.abel(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          );
                        });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StockDetails()));
                  }
                }),
             ListTile(
              leading: const Icon(
                Icons.calendar_month,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Slot Management",
                style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SlotListPage())),
            ),
            ListTile(
              leading: const Icon(
                Icons.feedback,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "FeedBack",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const feedback_page())),
            ),
            ListTile(
              leading: const Icon(
                Icons.message,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Complaint",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ComplaintPage())),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    firebaseSignOut();
                  },
                  child: Card(
                    elevation: 8,
                    child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightGreen),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
