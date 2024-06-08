import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackPageMobile extends StatefulWidget {
  final String email;
  const FeedBackPageMobile({super.key,required this.email});

  @override
  State<FeedBackPageMobile> createState() => _FeedBackPageMobileState();
}

class _FeedBackPageMobileState extends State<FeedBackPageMobile> {
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
  void addFeedback(String feedbackData) async {
    try {
      await FirebaseFirestore.instance.collection('CustomerFeedback').add({
        'email':widget.email,
        'feedback': feedbackData,
        'experience': exp_data,
        'date': DateTime.now().toString(),
        'cid': FirebaseAuth.instance.currentUser!.uid
      }).then((value) {
        feedbackController.clear();
        experienceIndex = 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Failed to Add the Feedback',
          style: GoogleFonts.aboreto(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.red,
        elevation: 5,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const userDashboard())),
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
                  EmojiFeedback(
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
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
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent,
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    onPressed: () {
                      addFeedback(feedbackController.text);
                      const ScaffoldMessenger(
          child: SnackBar(
            content: Text("ThankYou for your feedback"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
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
