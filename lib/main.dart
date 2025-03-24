import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For converting JSON

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _num = 1;
  String _data = "Click button for GET API data";
  String _postdata = "Click the bellow button for POST API data";

  // get api
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/$_num'));

    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body)['title']; // Extracting "title" from API response
        _num++;
      });
    } else {
      setState(() {
        _data = "Failed to load data";
      });
    }
  }

  // post api
  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": "Flutter API Example",
        "body": "This is a test post.",
        "userId": 1,
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _postdata = "Data sent successfully: ${response.body}";
      });
    } else {
      setState(() {
        _postdata = "Failed to send data";
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Call Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_data, textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Change button color
                foregroundColor: Colors.white, // Change text color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button size
                shape: RoundedRectangleBorder( // Rounded corners
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('GET Data'),
            ),


            Text(_postdata, textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change button color
                foregroundColor: Colors.white, // Change text color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button size
                shape: RoundedRectangleBorder( // Rounded corners
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('POST Data'),
            ),
          ],
        ),
      ),
    );
  }
}
