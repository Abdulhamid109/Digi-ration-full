import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackPageDesktop extends StatefulWidget {
  final String mgmail;
  const FeedBackPageDesktop({super.key,required this.mgmail});

  @override
  State<FeedBackPageDesktop> createState() => _FeedBackPageDesktopState();
}

class _FeedBackPageDesktopState extends State<FeedBackPageDesktop> {
  int MycurrentIndex = 0;
  var experienceIndex;
  var exp_data;
  void userExperience() {
    if (experienceIndex == 1) {
      exp_data = "Terrible";
    } else if (experienceIndex == 2) {
      exp_data = "Bad";
    } else if (experienceIndex == 3) {
      exp_data = "Good";
    } else if (experienceIndex == 4) {
      exp_data = "Very good";
    } else if (experienceIndex == 5) {
      exp_data = "Awesome";
    }
  }

  TextEditingController feedbackController = TextEditingController();

  //create a function to add the feedback in the database
  void addFeedback(String feedbackData) async{
    try {
      await FirebaseFirestore.instance.collection('CustomerFeedback').add({
        'gmail':widget.mgmail,
        'feedback': feedbackData,
        'experience': exp_data,
        'date': Timestamp.now().toDate(),
        'time': Timestamp.now(),
        'cid':FirebaseAuth.instance.currentUser!.uid
      }).then((value) {
        feedbackController.clear();
        const ScaffoldMessenger(
                        child: SnackBar(
                          content: Text("ThankYou for your feedback"),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                        ),
                      );
                      
                      experienceIndex=0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to Add the Feedback',style: GoogleFonts.aboreto(fontSize:20,fontWeight:FontWeight.w500),),
          backgroundColor: Colors.red,
          elevation: 5,
          duration: const Duration(seconds: 3),
        )
      );
    }
  }
  

  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
          actions: <Widget>[
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 20,
                  backgroundImage: AssetImage("images/user.jpg"),
                ),
              ),
            ),
          ],
        ),
        
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const Icon(
                    Icons.feedback,
                    size: 110,
                    // color: Colors.white10,
                    shadows: [
                      Shadow(
                          color: Colors.lightGreenAccent,
                          blurRadius: 10,
                          offset: Offset(5, 5)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "FeedBack",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "How was your Experience?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: width*0.45,
                    child: EmojiFeedback(
                      animDuration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn,
                      inactiveElementScale: .7,
                      onChanged: (value) {
                        // Do Something
                        setState(() {
                          experienceIndex = value;
                        });
                        userExperience();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width*0.65,
                    child: TextFormField(
                      controller: feedbackController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Suggestions",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      addFeedback(feedbackController.text);
                      
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
