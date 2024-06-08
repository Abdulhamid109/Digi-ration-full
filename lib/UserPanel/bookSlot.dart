import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newdigiration/UserPanel/bookConformation.dart';

class BookSlot extends StatefulWidget {
  final String gmail;
  const BookSlot({super.key,required this.gmail});

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  DateTime mydateTime = DateTime.now();
   int selectedIndex = -1;
   String slot = "";
   String Starttime = "";
   String Endtime = "";

void setSelectedIndex(int index){
  setState(() {
    selectedIndex = index;
  });


}

  void showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime.now().add(const Duration(days: 28)),
    ).then((value) => setState(() {
          mydateTime = value!;
        }));
  }

  
    int MycurrentIndex = 0;
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
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
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Column(
              children: <Widget>[
                //Icons for book slot
                Icon(
                  Icons.calendar_month_sharp,
                  size: 65,
                  color: Colors.lightBlue.shade200,
                  shadows: const [
                    Shadow(
                        color: Colors.greenAccent,
                        offset: Offset(5, 5),
                        blurRadius: 10)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Book Slot",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: height * 0.1,
                ),

                // select the date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: showDataPicker,
                      child: const Text(
                        "Select the date",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    IconButton(
                        onPressed: showDataPicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: height * 0.05,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Date: ${DateFormat.yMEd().format(mydateTime)}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                
                
                SizedBox(
                  height: height * 0.01,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Available Slots:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600))
                  ],
                ),
                //Morning slot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Morning slot",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                                backgroundColor: Colors.greenAccent),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setSelectedIndex(0);
                              
                            },
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: width*0.4,
                                decoration:selectedIndex==0? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent,
                                  border: Border.all(width: 2),
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent,),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("8:00 AM - 9:00 AM")),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap:()=>setSelectedIndex(1),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: width*0.4,
                                decoration:selectedIndex==1? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent,
                                  border: Border.all(width: 2)
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.greenAccent,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                      Center(child: Text("10:30 AM - 11:30 AM")),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: height * 0.01,
                ),
                //Evening Slot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange.shade300,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Evening slot",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: ()=>setSelectedIndex(2),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: width*0.4,
                                decoration:selectedIndex==2? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade300,
                                  border: Border.all(width: 2)
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade300,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("3:00 PM - 4:00 PM")),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: ()=>setSelectedIndex(3),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: width*0.4,
                                decoration: selectedIndex==3? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade300,
                                  border: Border.all(width: 2)
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade300,
                                  
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("5:30 PM - 6:30 AM")),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: height * 0.038,
                ),
                //Proceed button
                GestureDetector(
                  onTap: () {
                    if(selectedIndex==-1){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Please select a slot"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BookConfirmation(bookingDate: mydateTime,selectedIndex: selectedIndex,gmail: widget.gmail,)));
                    }
                  },
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade800,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Proceed",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
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
