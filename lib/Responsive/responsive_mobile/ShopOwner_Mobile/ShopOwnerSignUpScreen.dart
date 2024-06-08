import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/Dasboard.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/ShopOwnerLoginMobile.dart';
// import 'package:http/http.dart' as http;

class ShopOwnerRegisterPageMobile extends StatefulWidget {
  const ShopOwnerRegisterPageMobile({super.key});

  @override
  State<ShopOwnerRegisterPageMobile> createState() => ShopOwnerRegisterPageMobileState();
}

class ShopOwnerRegisterPageMobileState extends State<ShopOwnerRegisterPageMobile> {
  //formkey
  final formKey = GlobalKey<FormState>();
  //Controllers
  TextEditingController NameController = TextEditingController();
  TextEditingController LastController = TextEditingController();
  TextEditingController AdharController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  //toggle data
  bool clicked = true;

  void toggle() {
    setState(() {
      clicked = !clicked;
    });
  }

  
  //create a method SignUp
  void firebaseSignup(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.uid);
      addData(NameController.text,LastController.text,AdharController.text,phoneController.text,email,password);
      },
    )
    .catchError((e)=>{
      print(e.toString())
    });
  }

  void addData(String fname,String lname,String AadharNumber,String phonenumber, String email, String password) async {
  User? user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  if (user != null) {
    // User is signed in, proceed with adding data
    await FirebaseFirestore.instance
        .collection('ShopOwnerUsers')
        .doc(user.uid)
        .set({
          "FirstName": fname,
            "LastName":lname,
            "AadharNumber": AadharNumber,
            "PhoneNo": phonenumber,
            "Email": email,
            "Password": password,
          "uid": user.uid,
        })
        .then((value) {
           // No need for emailController and passwordController
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard()));
        })
        .catchError((error) {
          print("Error adding data to Firestore: $error");
          // Handle error, such as displaying an error message to the user
        });
  } else {
    // User is not signed in, handle this scenario (e.g., redirect to login screen)
    print("User is not signed in");
    // You might want to redirect the user to the login screen here
  }
}

  bool checkedBox = false;
  // Firebase Signup to Authentication
  





  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: width*0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Login text
                    Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Profile pic
                    
                    
                    // fristName
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: NameController,
                          decoration: InputDecoration(
                            hintText: "first name",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                              return 'Invalid first name. Use alphabets only';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                
                    const SizedBox(
                      height: 10,
                    ),
                
                    //Last name
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: LastController,
                          decoration: InputDecoration(
                            hintText: "Last name",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
                              return 'Invalid last name. Use alphabets only';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                
                    const SizedBox(
                      height: 10,
                    ),
                
                    // Adhar Card Number
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: AdharController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Adhar Card no.",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Adhar Card no.';
                            } else if (!RegExp(r"^\d{12}$").hasMatch(value)) {
                              return 'Invalid Adhar Card No. Use numbers only';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                
                    const SizedBox(
                      height: 10,
                    ),
                
                    //Phone no
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Phone no",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your phone no";
                            } else if (!RegExp(r"^(?:\+?91)?[6789]\d{9}$")
                                .hasMatch(value)) {
                              return "Invalid phone no";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Email
                
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: EmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter your email";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value)) {
                              return "Invalid Email";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                
                    const SizedBox(
                      height: 10,
                    ),
                    // Password
                    Card(
                      shadowColor: Colors.lightGreenAccent,
                      elevation: 3,
                      child: Container(
                        width: width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: PasswordController,
                          obscureText: clicked,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: toggle,
                                icon: clicked
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            hintText: "Enter Password",
                            hintStyle: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter the password";
                            } else if (!RegExp(
                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$")
                                .hasMatch(value)) {
                              return "Password Does not Statisfy the Criteria";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                checkedBox = !checkedBox;
                              });
                              print(" checkbox:$checkedBox");
                            },
                            value: checkedBox,
                          ),
                          Text(
                            "I have read & accept all the ",
                            style: GoogleFonts.abel(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "terms and conditions",
                            style: GoogleFonts.abel(
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Register button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 78, 207, 82),
                        shadowColor: Colors.black,
                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate() && checkedBox) {
                          firebaseSignup(EmailController.text.toLowerCase(), PasswordController.text);
                          
                              print("Iam here....");
                        } else {
                          // Handle the case when the form is not valid or terms and conditions are not accepted
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please fill out the form correctly and accept terms and conditions.",
                                style: GoogleFonts.damion(
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.lightBlueAccent,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: width * 0.3,
                        
                        child: Center(
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    // Register button
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an Account? ",
                          style: GoogleFonts.abel(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopOwnerLoginMobile())),
                          child: Text(
                            "Login",
                            style: GoogleFonts.abel(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
