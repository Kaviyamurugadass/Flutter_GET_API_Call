import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiListPage extends StatefulWidget {
  const ApiListPage({super.key});

  @override
  _ApiListPageState createState() => _ApiListPageState();
}

class _ApiListPageState extends State<ApiListPage> {
  List<dynamic> _dataList = [];
  bool _isLoading = false;

  Future<void> fetchData() async {
    setState(() => _isLoading = true);

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      setState(() {
        _dataList = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API List Page')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _dataList.isEmpty
              ? const Center(child: Text('No Data Available'))
              : ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: Text('${_dataList[index]['id']}')),
                      title: Text(_dataList[index]['title']),
                      subtitle: Text(_dataList[index]['body']),
                    );
                  },
                ),
    );
  }
}
