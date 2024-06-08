import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/Dasboard.dart';
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/ShopOwnerSignUpScreen.dart';
import 'package:newdigiration/Responsive/responsive_mobile/loginScreen.dart';

class ShopOwnerLoginMobile extends StatefulWidget {
  const ShopOwnerLoginMobile({super.key});

  @override
  State<ShopOwnerLoginMobile> createState() => _ShopOwnerLoginMobileState();
}

class _ShopOwnerLoginMobileState extends State<ShopOwnerLoginMobile> {
  final FormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool clicked = true;
  void toggle() {
    setState(() {
      clicked = !clicked;
    });
  }

  

  void firbaseLogin(String email, String password)async{
    //authenticate the user
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const Dashboard()));
    }).catchError((e){
      
       showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                e.code.toString(),
                style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          });
    
    });
  }

  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: FormKey,
          child: Center(
            child: Container(
              width: width*0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: height * 0.2,
                  ),
                  //Login text
                  Text(
                    "Login as shopOwner",
                    style: GoogleFonts.scheherazadeNew(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextField of userName and Password
                  Card(
                    shadowColor: Colors.lightGreenAccent,
                    elevation: 3,
                    child: Container(
                      width: width * 0.8,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Enter User name or Email",
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
              
                  const SizedBox(
                    height: 15,
                  ),
                  // Login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 97, 216, 101),
                      shadowColor: Colors.black,
                      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18)))
                    ),
                    onPressed: () async {
                      if (FormKey.currentState!.validate()) {
                        firbaseLogin(
                            usernameController.text, PasswordController.text);
                        
                      }
                    },
                      
                    child: Container(
                      height: 50,
                      width: width * 0.3,
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                        "Don't have an account? ",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShopOwnerRegisterPageMobile())),
                        child: Text(
                          "SignUp",
                          style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
              
                  //Login as shopkeeper
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "or",
                            style: GoogleFonts.eagleLake(
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          color: Colors.black,
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Continue as Customer, ",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreenMobile())),
                        child: Text(
                          "Login",
                          style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      )
                    ],
                  ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}