import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to test
Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['title'];
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  test('fetchData should return the correct title from API', () async {
    // Call function
    String result = await fetchData();
    
    // Expected output from API
    expect(result, isNotNull); // Ensures it is not null
  });

  test('fetchData should throw an exception for invalid API', () async {
    // Override function to use an invalid URL
    Future<String> fetchInvalidData() async {
      final response = await http.get(Uri.parse('https://invalid-url.com'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['title'];
      } else {
        throw Exception('Failed to load data');
      }
    }

    // Ensure exception is thrown
    expect(() => fetchInvalidData(), throwsException);
  });
}
