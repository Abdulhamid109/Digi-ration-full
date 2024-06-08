import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class feedback_page extends StatefulWidget {
  const feedback_page({super.key});

  @override
  State<feedback_page> createState() => _feedback_pageState();
}

class _feedback_pageState extends State<feedback_page> {
  
  String item1 = "Feedback Page";
  String item2 = "Complaint Page";
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.green, // Changed color to green
        elevation: 0,
        title:const Text(
            "Feedback",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search Feedbacks', // Changed hint text
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('CustomerFeedback').get(),
              builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Feedback found.'));
          }
          final feedback = snapshot.data!.docs.where((doc){
            final data = doc.data();
            final email = data['email']?.toLowerCase() ?? '';
            final experience = data['experience']?.toLowerCase() ?? '';
            final feedbackData = data['feedback']?.toLowerCase() ?? '';
            return email.contains(searchText) || experience.contains(searchText) ||  feedbackData.contains(searchText);
          }).toList();
             if (feedback.isEmpty) {
                  return const Center(child: Text('No feedback match your search.'));
                }
               return ListView.builder(
                itemCount: feedback.length,
                itemBuilder: (context, index) {
                  final mydata = feedback[index];
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        elevation: 8,
                        child: Container(
                          width: 200,
                          height: 170,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email: ${mydata['email']}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                 Text(
                                  "Experience: ${mydata['experience']}",
                                  style:const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                 Text(
                                  "Suggestions: ${mydata['feedback'] ?? "No Suggestions"}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                 Text(
                                  "Date: ${mydata['date'].toString()}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                },
              );
            
              },
            ),
          ),
        ],
      ),
    );
  }
}
