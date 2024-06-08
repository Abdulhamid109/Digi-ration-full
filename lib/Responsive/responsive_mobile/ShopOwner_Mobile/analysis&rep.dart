import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Analysiss extends StatefulWidget {
  const Analysiss({super.key});

  @override
  State<Analysiss> createState() => _AnalysissState();
}

class _AnalysissState extends State<Analysiss> {
  
  String item1 = "DashBoard";
  String item2 = "Logout";
  @override
  Widget build(BuildContext context) {
  final height = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title:  Text(
                "Analysis & Report",
                style: GoogleFonts.abrilFatface(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
       
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: Container(
                    height: height*0.4,
                    child:SfCartesianChart(
                      // legend: Legend(isVisible: true),
                      plotAreaBackgroundColor: const Color.fromARGB(255, 167, 159, 149),
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(minimum: 0,maximum: 12,interval: 2),
                      series: <CartesianSeries>[
                        ColumnSeries<Map<String, dynamic>, String>(
                          dataSource: const [
                            {'category': 'Rice', 'value': 5},
                            {'category': 'Wheat', 'value': 8},
                            {'category': 'Sugar', 'value': 3},
                            {'category': 'Oil', 'value': 7},
                            // Add more data points as needed
                          ],
                          xValueMapper: (Map<String, dynamic> data, _) =>
                              data['category'],
                          yValueMapper: (Map<String, dynamic> data, _) =>
                              data['value'],
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                        ),
                        // You can add more series if needed
                      ],
                    ),
                  ),
               
               
                ),
                SizedBox(height: height*0.02,),
            
                Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: Container(
                    height: height*0.4,
                    child:SfCartesianChart(
                      // legend: Legend(isVisible: true),
                      plotAreaBackgroundColor: const Color.fromARGB(255, 182, 173, 161),
                      plotAreaBorderColor: Colors.transparent,
                      plotAreaBorderWidth: 0,
                      primaryXAxis: const CategoryAxis(),
                      primaryYAxis: const NumericAxis(minimum: 0,maximum: 12,interval: 2),
                      series: <CartesianSeries>[
                        LineSeries<Map<String, dynamic>, String>(
                          dataSource: const [
                            {'category': 'Rice', 'value': 5},
                            {'category': 'wheat', 'value': 8},
                            {'category': 'Sugar', 'value': 3},
                            {'category': 'oil', 'value': 7},
                            
                          ],
                          xValueMapper: (Map<String, dynamic> data, _) =>
                              data['category'],
                          yValueMapper: (Map<String, dynamic> data, _) =>
                              data['value'],
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                        ),
                        // You can add more series if needed
                      ],
                    ),
                  ),
               
               
                ),
              
              
              ],
            ),
          ),
        ),
      ),
      // drawer: const MenuBarr(),
    );
  }
}
