import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Customer list',style: GoogleFonts.abel(fontSize:15,fontWeight:FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users slots found.'));
          }

          var users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var myuser = users[index];
              var userfName = myuser['FirstName'];
              var userlName = myuser['LastName'];
              var userEmail = myuser['Email'];  
              var Adhar = myuser['AadharNumber'];

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text('$userfName $userlName'),
                subtitle: Row(
                  children: [
                    Text(userEmail),
                    const SizedBox(width: 20),
                    Text(Adhar)

                  ],
                ),
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