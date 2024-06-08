import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/PDS02.dart';

class PDS01 extends StatefulWidget {
  const PDS01({super.key});

  @override
  State<PDS01> createState() => _PDS01State();
}
final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
//function to add the benificiery details
 Future<void> addBeneficiary01() async {
    try {
      await FirebaseFirestore.instance.collection('beneficiary01').add({
        'first_name': firstNameController.text,
        'middle_name': middleNameController.text,
        'last_name': lastNameController.text,
        'aadhar_number': aadharController.text,
        'mobile_number': mobileController.text,
        'email': emailController.text,
        'income': incomeController.text,
        'nationality': nationalityController.text,
        'address': addressController.text,
        'city': cityController.text,
        'state': stateController.text,
        'pin': pinController.text,
      }).then((value) {
// Clear all controllers after data is stored
      firstNameController.clear();
      middleNameController.clear();
      lastNameController.clear();
      aadharController.clear();
      mobileController.clear();
      emailController.clear();
      incomeController.clear();
      nationalityController.clear();
      addressController.clear();
      cityController.clear();
      stateController.clear();
      pinController.clear();
      // Navigate to next screen after data is stored
      
      });
      
    } catch (e) {
      print("Error adding beneficiary: $e");
      // Handle error
    }
  }

  
class _PDS01State extends State<PDS01> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          "New PDS Beneficiary Registration",
          style: GoogleFonts.aclonica(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        
      ),
      
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Full Name",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: "Frist name",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    
                    ),
                  ),
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: middleNameController,
                        decoration: InputDecoration(
                          labelText: "Middle name",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: "Last name",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    ),
                  )
                
                ],
              ),
               
               SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Aadhar Number",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: aadharController,
                    keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "XXXX-XXXX-XXXX",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
        
               SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Mobile Number",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "+91 xxxxxxxxxx",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
        
                 SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Email",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              
                              labelText: "abc@gmail.com",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
                    
               SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Yearly Income",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: incomeController,
                    keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Income",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
                
                 SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Nationality",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: nationalityController,
                            decoration: InputDecoration(
                              labelText: "Indian",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
                
               SizedBox(height: height*0.02,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Local Address",style: GoogleFonts.abhayaLibre(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.lightGreen,
                  child: TextFormField(
                    controller: addressController,
                            decoration: InputDecoration(
                              labelText: "Address Line 1",
                              labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(width: 1),
                                
                              ),
                            ),
                          ),
                ),
              ),
               
               SizedBox(height: height*0.02,),
                
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: height*0.07,
                    width: width*0.277,
                    child: Text("City",style: GoogleFonts.aboreto(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    height: height*0.07,
                    width: width*0.277,
                    child: Text("State",style: GoogleFonts.aboreto(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
        
                  Container(
                    height: height*0.07,
                    width: width*0.277,
                    child: Text("Pin",style: GoogleFonts.aboreto(fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                
                ],
              ),
               
        
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                          labelText: "City Name",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    
                    ),
                  ),
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(
                          labelText: "State Name",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  Card(
                    elevation: 3,
                    shadowColor: Colors.lightGreen,
                    child: Container(
                      height: height*0.07,
                      width: width*0.277,
                      child: TextFormField(
                        controller: pinController,
                        decoration: InputDecoration(
                          labelText: "XXXXXX",
                          labelStyle: GoogleFonts.aboreto(fontSize: 15,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1),
                            
                          ),
                        ),
                      ),
                    ),
                  )
                
                ],
              ),
              SizedBox(height: height*0.03,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Text("Cancel",style: GoogleFonts.aoboshiOne(fontSize: 20,fontWeight: FontWeight.w500,decoration: TextDecoration.underline),)),

                  GestureDetector(
                    onTap: (){
                      addBeneficiary01();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PDS02()));
                    },
                    
                    child: Card(
                      elevation: 3,
                      color: Colors.lightBlueAccent,
                      shadowColor: Colors.lightBlue,
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(18, 18),
                              blurRadius: 20,
                            ),
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(-4, -4),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Proceed",style: GoogleFonts.aclonica(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    
                    )
                ],
              )
               
              
              ],
          ),
        ),
      ),

      //Dashboard
      
    );
  }
}
