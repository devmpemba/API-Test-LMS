import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String apiUrl = 'https://digitalloans.imt.co.tz/api/quotation/CreateIPFSubmit';

  TextEditingController channelController = TextEditingController();
  TextEditingController loanProductIdController = TextEditingController();
  // Add controllers for other text fields

  Future<void> _postData() async {
    try {
      Map<String, dynamic> jsonData = {
        "channel": channelController.text,
        "loan_product_id": loanProductIdController.text,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully!');

      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Policy Pro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: channelController,
              decoration: InputDecoration(labelText: 'Channel'),
            ),
            TextField(
              controller: loanProductIdController,
              decoration: InputDecoration(labelText: 'Loan Product ID'),
            ),
            // Add other text fields for the remaining data

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                _postData();
              },
              child: Text('Send Data to API'),
            ),
          ],
        ),
      ),
    );
  }
}
