import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/DBModal/UserModal.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/ComplaintsRecord.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/FeedBackPage.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/loginScreen.dart';
import 'package:newdigiration/UserPanel/bookSlot.dart';
import 'package:newdigiration/UserPanel/bookings.dart';

class UserMenuDesktop extends StatefulWidget {
  final String mgmail;
  const UserMenuDesktop({super.key,required this.mgmail});

  @override
  State<UserMenuDesktop> createState() => _UserMenuDesktopState();
}

class _UserMenuDesktopState extends State<UserMenuDesktop> {
   //create a function to fetch the current user information
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    return Drawer(
        backgroundColor: Colors.lightGreenAccent,
        child: Container(
          color: Colors.lightGreenAccent,
          child: ListView (
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
                    
                    // Text("${fullname==null?defaultName:fullname}",style: TextStyle(fontWeight: FontWeight.w500),)
                  Center(
                    child: FutureBuilder<UserData>(
                      future:getCurrentUserData() ,
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Text('loading...');
                        }else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }
                        else{
                          return Text("${snapshot.data!.FirstName} ${snapshot.data!.LastName}",style: GoogleFonts.abel(fontSize:18,fontWeight:FontWeight.w400),);
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
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 20,
                  backgroundImage: AssetImage("images/user.jpg"),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.book_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                title: const Text(
                  "Slot Booking",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) =>  BookSlot(gmail: widget.mgmail,))));
                }
              ),
              ListTile(
                leading: const Icon(
                  Icons.feedback_sharp,
                  size: 35,
                  color: Colors.white,
                ),
                title: const Text(
                  "FeedBack",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>const FeedMain())),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  FeedBackPageDesktop(mgmail: widget.mgmail,))),
              ),
              const ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  "Customer Care",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.calendar_view_week_sharp,
                  size: 35,
                  color: Colors.white,
                ),
                title: const Text(
                  "Slot Status",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bookings())),
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
                        builder: (context) => ComplaintsRecordDesktop(gmail: widget.mgmail,))),
              ),
              const ListTile(
                leading: Icon(
                  Icons.abc,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      //Logout
                      // var sharedpref = await SharedPreferences.getInstance();
                      // sharedpref.setBool(
                      //     ShopOwnerSplashScreenState.KEYLOGIN, false);
                      try {
                        await FirebaseAuth.instance.signOut();
                        print("Successfully Signed out");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenDesktop()));
                      } on FirebaseAuthException catch (exp) {
                        print(exp.code.toString());
                      }
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