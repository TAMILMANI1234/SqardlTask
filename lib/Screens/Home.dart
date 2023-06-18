import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Auth.dart';
import './Explore.dart';
import 'package:college/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> universities = [];
  bool isLoading = false;  // For Loading

  Future<void> fetchdata() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=India'));
    if (response.statusCode == 200) {
      setState(() {
        universities = jsonDecode(response.body);
      });
    } else {
      print('Failed to fetch universities');
    }

    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Indian University List'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(onPressed:() {
            Auth().Signout();
            Navigator.pop(context);
          },
            icon: Icon(Icons.logout),tooltip: 'account',),
        ],
      ),

      body: isLoading
          ?const Center(
             child: CircularProgressIndicator(),
          ):
          ListView.builder(
            itemCount: universities.length,
             itemBuilder: (context, index) {
             final university = universities[index];
             return Card(
                elevation: 5,
                child: ListTile(
                  leading:const Icon(Icons.apartment),
                  title: Text(university['name']),
                  subtitle: Text(university['country']),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  Explore(universityData: university)));
                  },
                ),
               );
        },
      ),
    );
  }
}
