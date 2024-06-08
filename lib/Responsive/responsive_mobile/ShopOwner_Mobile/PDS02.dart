import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:newdigiration/Responsive/responsive_mobile/ShopOwner_Mobile/PDS_Page03.dart';





class PDS02 extends StatefulWidget {
  const PDS02({super.key});

  @override
  State<PDS02> createState() => _PDS02State();
}

class _PDS02State extends State<PDS02> {
 String? _photoPath;
  String? _signaturePath;

  Future<void> _pickPhoto() async {
    file_picker.FilePickerResult? result =
    await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _photoPath = result.files.single.path;
      });
    }
  }

  Future<void> _pickSignature() async {
    file_picker.FilePickerResult? result =
    await file_picker.FilePicker.platform.pickFiles(
      type: file_picker.FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _signaturePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text(
          'PDS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
       
      ),
      
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New PDS Beneficiary Registration',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_photoPath != null)
                        Image.file(
                          File(_photoPath!),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue
                          ),
                          onPressed: _pickPhoto,
                          child: const Text(
                            'Choose Photo',
                            style: TextStyle(color: Colors.white),
                          ),
                          
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (_signaturePath != null)
                        Image.file(
                          File(_signaturePath!),
                          width: 200,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue
                          ),
                          onPressed: _pickSignature,
                          child: const Text(
                            'Choose Signature',
                            style: TextStyle(color: Colors.white),
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement back functionality
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
                  ),
                  
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent
                  ),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PDS03()));
                  },
                  child:const Text(
                    'Proceed',
                    style: TextStyle(color: Colors.black),
                  ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}