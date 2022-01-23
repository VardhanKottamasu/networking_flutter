import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:networking_flutter/DetailsPage.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final String url="https://jsonplaceholder.typicode.com/photos/";
  var data;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  @override
  void dispose() {
    super.dispose();
  }

  fetchData() async {
    var res=await http.get(Uri.parse(url));
    setState(() {
      data=jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking App"),
      ),
        body: data!=null?Center(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: ()
                    {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=>DetailsPage(data[index]["url"]),
                          ),
                      );
                    },
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Hero(
                            tag: "tag",
                            child: Image.network(
                              data[index]["url"],
                              fit: BoxFit.cover,
                        ),
                          )
                        ),
                        Text(
                          (index+1).toString()+". "+data[index]["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ):const Center(
            child: CircularProgressIndicator()
        ),
    );
  }
}