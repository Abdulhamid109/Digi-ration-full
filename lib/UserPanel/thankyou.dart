import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';

class ThankyouPage extends StatefulWidget {
  const ThankyouPage({super.key});

  @override
  State<ThankyouPage> createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  int MycurrentIndex = 0;
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
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
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 20,
              backgroundImage: AssetImage("images/user.jpg"),
            ),
          ),
        ],
      ),
      
      
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                  child: Card(
                    shape: const CircleBorder(),
                    elevation: 14,
                    shadowColor: Colors.black,
                    child: IconAnimated(
                      color: Colors.green,
                      active: isActive, // boolean
                      size: 150,
                      iconType: IconType.check,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                TextLiquidFill(
                  text: "Thank You!!",
                  waveColor: Colors.blueAccent,
                  boxBackgroundColor:Colors.white ,
                  boxHeight:70,
                  boxWidth: 400,
                  textStyle: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
                // AnimatedTextKit(
                //   displayFullTextOnTap: true,
                //   repeatForever: true,
                //   isRepeatingAnimation: true,
                //   animatedTexts: [
                //     // TyperAnimatedText("Thank You!!",
                //     //     textStyle: const TextStyle(
                //     //       fontSize: 50,
                //     //       fontWeight: FontWeight.bold,
                //     //       color: Colors.green,
                //     //     ),
                //     //     speed: const Duration(milliseconds: 230))
                //   ],
                // ),
                
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: AnimatedTextKit(
                    displayFullTextOnTap: true,
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TypewriterAnimatedText("Your Slot has been Successfully booked",
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                          speed: const Duration(milliseconds: 230))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
