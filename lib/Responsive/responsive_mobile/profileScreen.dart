import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newdigiration/DBModal/UserModal.dart';

class ProfileScreenMobile extends StatefulWidget {
  const ProfileScreenMobile({super.key});

  @override
  State<ProfileScreenMobile> createState() => _ProfileScreenMobileState();
}

class _ProfileScreenMobileState extends State<ProfileScreenMobile> {
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
    final width = MediaQuery.of(context).size.width*1;
    return  Scaffold(
      body: Center(
        child: Container(
          width: width*0.45,
          height: height*0.65,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: Colors.black,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: FutureBuilder(
                future: getCurrentUserData(), 
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                          return const Text('loading...');
                        }else if(snapshot.hasError){
                          return Text("${snapshot.error}");
                        }else{
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('images/user.jpg'),
                        ),
                        title: Text('Name: ${snapshot.data!.FirstName} ${snapshot.data!.LastName}'),
                      ),
                      ListTile(
                        title: Text('Adhar No: ${snapshot.data!.AadharNumber}'),
                      ),
                      ListTile(
                        title: Text('Phone No: ${snapshot.data!.PhoneNo}'),
                      ),
                      ListTile(
                        title: Text('Email: ${snapshot.data!.Email}'),
                      ),
                    
                    ],
                  );
                        }
                },
                
                )
            ),
          ),
        ),
      ),
    );
  }
}