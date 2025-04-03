import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tuan_01/model/customer.dart';
import 'package:tuan_01/screen/ViewDetailScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Customer> customers = [];

  Future<void> fetchCustomers() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> jsonList = jsonDecode(response.body);
        customers = jsonList.map((json) => Customer.fromJson(json)).toList();
      });
      print("Load customers successed.");
    } else {
      throw Exception("Failed to load customers");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 50, // Định kích thước cho cột ID
                  child: Text(
                    "ID",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2, // Cột NAME rộng hơn ID
                  child: Text(
                    "NAME",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1, // Cột PHONE có độ rộng tương đương NAME
                  child: Text(
                    "PHONE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List content
          Expanded(
            child: ListView.separated(
              itemCount: customers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(customer.id.toString()),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                customer.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            customer.phone,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ViewDetailScreen(customer: customer),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
