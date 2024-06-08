import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlotListPage extends StatefulWidget {
  const SlotListPage({super.key});

  @override
  State<SlotListPage> createState() => _SlotListPageState();
}

class _SlotListPageState extends State<SlotListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Customer slot list',style: GoogleFonts.abel(fontSize:15,fontWeight:FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('UserSlot').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users slots found.'));
          }

          var usersSlot = snapshot.data!.docs;

          return ListView.builder(
            itemCount: usersSlot.length,
            itemBuilder: (context, index) {
              var myuser = usersSlot[index];
              var userEmail = myuser['gmail']; 
              var userDate = myuser['Date']; 

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(userEmail),
                subtitle: Text(userDate),
                onTap: () {
                  // Handle onTap if needed
                  print('Tapped on $userEmail');
                },
              );
            },
          );
        },
      ),
    );
  }
}