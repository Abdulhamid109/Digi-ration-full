
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:newdigiration/DBModal/UserModal.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/PDS_Page01.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/ShopOwnerLoginMobile.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/Shop_Widgets/Menubar.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/analysis&rep.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/slot_management.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/viewCustomer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<UserData> getCurrentShopUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = auth.currentUser;

  if (user != null) {
    // Get the document corresponding to the user from Firestore
    DocumentSnapshot snapshot = await firestore.collection('ShopOwnerUsers').doc(user.uid).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Convert the data from Firestore to your UserData model
      UserData userData = UserData.fromMap(snapshot.data() as Map<String, dynamic>);
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

  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width*1;
    String item1 = "DashBoard";
    String item2 = "Logout";
    return SafeArea(
      child: Scaffold(        
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          actions: [
            const Icon(Icons.person),
            GestureDetector(
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: item1,
                      child: Text(item1),
                      onTap: () => setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                          })),
                  PopupMenuItem(
                      value: item2,
                      child: Text(item2),
                      onTap: () => setState(() async{
                        await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const ShopOwnerLoginMobile()), (route) => false);
                          })),
                ],
                icon: const Icon(Icons.arrow_drop_down_circle),
              ),
            
            
            ),
          ],
          
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<UserData>(
                    future:getCurrentShopUserData() ,
                    builder: (context,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const Text('Loading..');
                      }else if(snapshot.hasError){
                        return Text("${snapshot.error}");
                      }
                      else{
                        return Text("Welcome ${snapshot.data!.FirstName}",style: GoogleFonts.podkova(fontSize:20,fontWeight:FontWeight.bold),);
                      }
                    },
                  ),
               
                        ],
                      ),
                    ),
                    const InstaImageViewer(
                      child: CircleAvatar(
                        // backgroundColor: Colors.black54,
                        radius: 35,
                        backgroundImage: AssetImage("images/user.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  height: height * 0.62,
                  
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.green[900],
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children:  <Widget>[
                          // item1
                           Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Card(
                              elevation: 4,
                              color: Colors.lightGreenAccent,
                              child: Container(
                                height: height*0.2,
                                
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      // backgroundColor: Colors.black54,
                                      radius: 37,
                                      backgroundImage:
                                          AssetImage("images/user.jpg"),
                                    ),
                                    Text(
                                      "View Profile",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // item2
                          Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const Analysiss())),
                              child: const Card(
                                elevation: 4,
                                color: Colors.lightGreenAccent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      size: 60,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black45,
                                            offset: Offset(2, 2))
                                      ],
                                    ),
                                    Text(
                                      "Reports",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // item3
                           Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: GestureDetector(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const PDS01()));},
                              child: const Card(
                                elevation: 4,
                                color: Colors.lightGreenAccent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      size: 60,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black45,
                                            offset: Offset(2, 2))
                                      ],
                                    ),
                                    Text(
                                      "New Customer",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // item4
                           Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserListPage())),
                              child: const Card(
                                elevation: 4,
                                color: Colors.lightGreenAccent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black45,
                                            offset: Offset(2, 2))
                                      ],
                                    ),
                                    Text(
                                      "View Customer",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // item5
                          const Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Card(
                              elevation: 4,
                              color: Colors.lightGreenAccent,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.stacked_bar_chart,
                                    size: 60,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black45,
                                          offset: Offset(2, 2))
                                    ],
                                  ),
                                  Text(
                                    "Stock Management",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // item6
                           GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const SlotListPage())),
                             child: const Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Card(
                                elevation: 4,
                                color: Colors.lightGreenAccent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 60,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black45,
                                            offset: Offset(2, 2))
                                      ],
                                    ),
                                    Text(
                                      "slot Management",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                                                       ),
                           ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      "Total Sales:",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Weight: 355 kg",style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w300),),
                        Text("Sales: Rs 5250",style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //Dashboard
        drawer: const MenuBarr()
      ),
    );
  
  }
}
