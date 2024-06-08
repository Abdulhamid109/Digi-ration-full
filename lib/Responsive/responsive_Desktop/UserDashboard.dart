import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/DBModal/UserModal.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/ComplaintPage.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/FeedBackPage.dart';

import 'package:newdigiration/UserPanel/bookSlot.dart';
import 'package:newdigiration/UserPanel/bookings.dart';

import 'package:newdigiration/Responsive/responsive_mobile/mymenu.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class userDashboardDesktop extends StatefulWidget {
  final String mgmail;
  const userDashboardDesktop({super.key,required this.mgmail});

  @override
  State<userDashboardDesktop> createState() => _userDashboardDesktopState();
}

class _userDashboardDesktopState extends State<userDashboardDesktop> {
  int activeIndex = 0;
  int mycurrentIndex = 0;
  var defaultName = "Parth Desai";
  
  Future<UserData> getCurrentUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the current user
  User? user = auth.currentUser;

  if (user != null) {
    // Get the document corresponding to the user from Firestore
    DocumentSnapshot snapshot = await firestore.collection('users').doc(user.uid).get();

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
  void initState() {
    super.initState();
    // fetchUserData();
    
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: const Text(
          "DIGI - RATION",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/user.jpg"),
              backgroundColor: Colors.black,
            ),
          )
        ],
      ),

      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              // Welcome

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<UserData>(
                    future:getCurrentUserData() ,
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
                  
              const SizedBox(
                height: 18,
              ),

              // Looking for
              const Row(
                children: <Widget>[
                  Text(
                    "Looking for",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),
              //different navigations
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //item 1
                    GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> BookSlot(gmail: widget.mgmail,))),
                      child: Column(
                        children: [
                          Card(
                            shadowColor: Colors.lightGreen,
                            elevation: 4,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset("images/calender.png"),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Slot Booking",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),
                    //item2
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bookings())),
                      child: Column(
                        children: [
                          Card(
                            elevation: 4,
                            shadowColor: Colors.lightGreen,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset("images/management.png"),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Slot Management",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),
                    //item3
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  FeedBackPageDesktop(mgmail: widget.mgmail,))),
                      child: Column(
                        children: [
                          Card(
                            shadowColor: Colors.lightGreen,
                            elevation: 4,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset("images/feedback.png"),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Feedback",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),
                    //item4
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ComplaintPageDesktop(gmail: widget.mgmail,))),
                      child: Column(
                        children: [
                          Card(
                            shadowColor: Colors.lightGreen,
                            elevation: 4,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset("images/complaint.jpg"),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Complaint",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],

                  //
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //Popular
              const Row(
                children: <Widget>[
                  Text(
                    "Popular",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),
              // image crasouel
              Column(
                children: [
                  CarouselSlider(
                    items: [
                      //item1
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Stack(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Image.asset(
                                  "images/im1.jpeg",
                                  fit: BoxFit.fill,
                                  height: height * 0.5,
                                )),
                            Center(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.teal[50],
                                    shadowColor: Colors.lightGreen,
                                    elevation: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Read more",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //item2
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Image.asset(
                                    "images/pradhan-mantri-garib-kalyan-yojana.jpg",
                                    fit: BoxFit.fill,
                                    height: height * 0.5,
                                  )),
                              Center(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.teal[50],
                                      shadowColor: Colors.lightGreen,
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Read more",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      //item3
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Image.asset(
                                    "images/im3.png",
                                    fit: BoxFit.fill,
                                    height: height * 0.5,
                                  )),
                              Center(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.teal[50],
                                      shadowColor: Colors.lightGreen,
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Read more",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      //item4
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Image.asset(
                                    "images/pradhanmantri-gareeb-kalyan-yojana.jpg",
                                    fit: BoxFit.fill,
                                    height: height * 0.5,
                                  )),
                              Center(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.teal[50],
                                      shadowColor: Colors.lightGreen,
                                      elevation: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Read more",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      clipBehavior: Clip.antiAlias,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildIndicator(),
                  ),
                ],
              ),

              //Upcoming
              const Row(
                children: <Widget>[
                  Text(
                    "Upcoming",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              //bottom data
              Card(
                color: Colors.white,
                elevation: 2,
                shadowColor: Colors.lightGreenAccent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightGreen,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "19",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                "oct",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(width: 20,),
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ration Collection",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Rice",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Tuesday, 04:30pm",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //Drawer
      drawer:  UserMenu(gmail: widget.mgmail,),
    
    );

  }
    

  // indicator dots widgets
  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: const ExpandingDotsEffect(
          activeDotColor: Colors.blue, dotWidth: 3, dotHeight: 2),
      activeIndex: activeIndex,
      count: 4);
}
