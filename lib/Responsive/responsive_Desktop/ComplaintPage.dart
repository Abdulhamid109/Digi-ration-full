
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/ComplaintsRecord.dart';


class ComplaintPageDesktop extends StatefulWidget {
  final String gmail;
  const ComplaintPageDesktop({super.key,required this.gmail});

  @override
  State<ComplaintPageDesktop> createState() => _ComplaintPageDesktopState();
}

class _ComplaintPageDesktopState extends State<ComplaintPageDesktop> {
  int MycurrentIndex = 0;
  String name = "Shop Owner";
  TextEditingController issueController = TextEditingController();
  DateTime time = DateTime.now();
  void showdate(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
       firstDate: DateTime.now().subtract(const Duration(days: 28)), 
       lastDate: DateTime.now().add(const Duration(days: 0))
       ).then((value) {
       setState(() {
         time = value!;
       }); 
       
       });
  }
  
  // function to register the complaint in the database
  void addCompliant(String issue) async{
    await FirebaseFirestore.instance.collection('UserComplaints').add({
      'issuToname': name,
      'issue': issue,
      'Date': time.toString(),
      'email': widget.gmail,
      'status': 'Ongoing',
      'uid':FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      issueController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ComplaintsRecordDesktop(gmail: widget.gmail,)));
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width*1;

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
          actions: <Widget>[
            GestureDetector(
              // onTap: () => Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const userDashboard())),
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
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Complaint",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 20,),
         
                Container(
                  width:width*0.6 ,
                  child: Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreenAccent,
                   child: Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Complaint to",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
                              ],
                            ),
                           
                            DropdownButton<String>(
                              icon:const Icon(Icons.arrow_drop_down,size: 30,),
                              isExpanded: true,
                              items: const[
                                DropdownMenuItem(
                                  value: 'Shop Owner',
                                  child: Text("Shop Owner",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  ),
                                DropdownMenuItem(
                                  value: 'Administrator',
                                  child: Text("Administrator",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  ),
                              ],
                              value: name,
                              onChanged: (value) {
                                setState(() {
                                  name = value as String;
                                });
                              },
                              
                              ),
                           
                              const SizedBox(height: 10,),
                              const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Date:",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
                              ],
                            ),
                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: showdate,
                                  child:  Text(DateFormat('EEE, M/d/y').format(time),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                  ),
                            
                            IconButton(onPressed: showdate, icon:const Icon(Icons.arrow_drop_down,size: 30,), )
                              ],
                            ),
                           
                            const Divider(thickness: .1,color: Colors.black,indent: 0),
                            const SizedBox(height: 7,),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Describe your issue",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
                              ],
                            ),
                            const SizedBox(height: 7,),
                            TextFormField(
                              controller: issueController,
                        maxLines: 7,
                        
                        decoration: const InputDecoration(
                         fillColor: Colors.white,
                         filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                           const SizedBox(height: 8,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        onPressed: () {
                          // insertComplaint();
                          addCompliant(issueController.text);
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          child: const Center(child:  Text("Submit",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                        ),
                      )
                     
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
         ),
       ),
    );
  
  }
}