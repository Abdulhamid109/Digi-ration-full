// Define your UserData model class
class UserData {
  final String FirstName;
  final String LastName;
  final String AadharNumber;
  final String PhoneNo;
  final String Email;
  final String Password;
  // Add more fields as per your Firestore document

  UserData({
    required this.FirstName,
    required this.LastName,
    required this.AadharNumber,
    required this.PhoneNo,
    required this.Email,
    required this.Password,
    // Add more fields as per your Firestore document
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      FirstName: map['FirstName'] ?? '',
      LastName: map['LastName'] ?? '',
      AadharNumber: map['AadharNumber'] ?? '',
      PhoneNo: map['PhoneNo'] ?? '',
      Email: map['Email'] ?? '',
      Password: map['Password'] ?? '',
      // Add more fields as per your Firestore document
    );
  }
}