// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color primaryColor = Color.fromARGB(255, 149, 182, 239);
  Color bgColor = const Color.fromARGB(255, 116, 115, 115);
  String URL = "http://worldtimeapi.org/api/timezone/Asia/Kathmandu";

  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    fetchCurrentTime();
    locallyTimeIncre();
    super.initState();
  }

  Future<void> fetchCurrentTime() async {
    try {
      var response = await http.get(Uri.parse(URL));
      var decodedResponse = jsonDecode(response.body);
      currentTime = DateTime.parse(decodedResponse['datetime']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> locallyTimeIncre() async {
    await Future.delayed(Duration(seconds: 1), () async {
      currentTime = currentTime.add(Duration(seconds: 1));
      setState(() {});
      await locallyTimeIncre();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat(' MMMM , EEEE d');
    String formattedDate = dateFormat.format(currentTime);
    String fromattedTime = DateFormat("h:mma").format(currentTime);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          "Time",
          style: TextStyle(
            fontSize: 30,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  fetchCurrentTime();
                });
              },
              icon: Icon(
                Icons.replay_outlined,
                size: 35,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Divider(
                thickness: 3,
                color: primaryColor,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 29, 28, 28),
                        blurRadius: 5,
                      )
                    ],
                    border: Border.all(
                      color: primaryColor,
                      width: 3.5,
                    ),
                    borderRadius: BorderRadius.circular(
                      10,
                    )),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentTime.hour.toString(),
                            style: TextStyle(
                              fontSize: 90,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: bgColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                size: 15,
                                Icons.circle,
                                color: bgColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            currentTime.minute.toString(),
                            style: TextStyle(
                                fontSize: 90, color: Colors.deepOrange),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "PM",
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                currentTime.second.toString(),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "$formattedDate",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: [
                Text(
                  "Made By:",
                  style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Name: Bikal Chudal",
                  style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Email: bikalchudal11@gmail.com",
                  style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
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
