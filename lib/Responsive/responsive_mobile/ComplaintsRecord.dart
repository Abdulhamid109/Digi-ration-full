
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ComplaintPage.dart';
// import 'package:intl/intl.dart';

class ComplaintsRecordMobile extends StatefulWidget {
  final String gmail;
  const ComplaintsRecordMobile({super.key,required this.gmail});

  @override
  State<ComplaintsRecordMobile> createState() => _ComplaintsRecordMobileState();
}

class _ComplaintsRecordMobileState extends State<ComplaintsRecordMobile> {
  int MycurrentIndex = 0;
  void deleteComplaintDailog(String documentId)async{
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Center(child: Text('Delete Compaint'),),
        content: const Text('Are you sure you want to delete'),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('cancel')),
          TextButton(onPressed: ()async{
            try {
              await FirebaseFirestore.instance.collection('UserComplaints').doc(documentId).delete();
            } catch (e) {
              print('Exception');
            }
            Navigator.pop(context);
          }, child: const Text('Delete')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height*1;
  double width = MediaQuery.of(context).size.width*1;
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
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your Complaints",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 3,
                  color: Colors.white,
                  shadowColor: Colors.lightGreenAccent,
                  child: Container(
                    width: double.infinity,
                    height:height*0.8 ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               ComplaintPageMobile(gmail:widget.gmail ,))),
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.lightGreen,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "New Complaints",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('UserComplaints').where('uid',isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                print(FirebaseAuth.instance.currentUser!.uid);
                                print(snapshot.data!.docs.length);
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Center(child: Text("No Compaints found"),);
                                }
                                if(snapshot.hasError){
                                  return const Center(child: Text("Error Occured Try again"),);
                                }
 
                               return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder:(context, index) {
                                final data = snapshot.data!.docs[index];
                                print('${data.id}');
                                return  GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                     builder: (context) {
                                      return AlertDialog(
                                        title: Center(child: Text('Complaint ${index+1}'),),
                                        content: Container(
                                          height: height*0.4,
                                          width: width*0.5,
                                          child: Center(
                                            child: Text(
                                              '${data['issue']}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                              onPressed: ()=>Navigator.pop(context),
                                              child: const Text('OK'),
                                            ),
                                          )
                                        ],
                                      );
                                    },);
                                  
                                  },
                                  child: Card(
                                                                elevation: 4,
                                                                child: ListTile(
                                  title: Text(
                                    "${data['issuToname']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightGreen),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Complaint No:${index+1}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Status:${data['status']}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 5,),
                                          IconButton(
                                            onPressed: (){
                                              deleteComplaintDailog(data.id);
                                            },
                                            icon: const Icon(Icons.delete,color: Colors.red,),
                                            tooltip: 'Delete',
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                                                ),
                                                              ),
                                );
                            
                              }, );
                          
                              },
                            )
                          )
                          
                          
                          
                          
                          
                          
                          
                        ],
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
