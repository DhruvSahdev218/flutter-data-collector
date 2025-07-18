import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(DataCollectorApp());

class DataCollectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataForm(),
    );
  }
}

class DataForm extends StatefulWidget {
  @override
  _DataFormState createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> submitData() async {
    final url = Uri.parse('http://localhost:5000/submit');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
        }));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Success"),
                content: Text(result['message']),
              ));
    } else {
      print('Error submitting data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Collection Form')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submitData, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
