import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/TO%20DO%20App/Task_Add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_backend/TO DO App/Task_details.dart';

import '../Add_And_View/View_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var Name_ctrl = TextEditingController();
  var Createdate_ctrl = TextEditingController();
  var Discription_ctrl = TextEditingController();
  var Lastdate_ctrl = TextEditingController();

  final List<String> _Duriation = [
    'Upto 12 Hour',
    'Upto 1 Day',
    'Upto 1 Week',
    'Upto 1 Month',
    'Upto 1 Year',
    ' Select'
  ];

  String Selected_item = ' Select';

  Future<void> Update_task(String id, String name, String createdate,
      String description, String selected_item, String lastdate) async {
    Name_ctrl.text = name;
    Createdate_ctrl.text = createdate;
    Discription_ctrl.text = description;
    Lastdate_ctrl.text = lastdate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.purple.shade100,
          title: Text('Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: Name_ctrl,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: Createdate_ctrl,
                decoration: InputDecoration(labelText: 'Creation Date'),
              ),
              TextField(
                controller: Discription_ctrl,
                decoration: InputDecoration(labelText: 'Product Description'),
              ),
              DropdownButton<String>(
                dropdownColor: Colors.purple.shade100,
                value: Selected_item,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                ),
                items: _Duriation.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    Selected_item = newValue!;
                  });
                },
              ),
              TextField(
                controller: Lastdate_ctrl,
                decoration: InputDecoration(labelText: 'Last Date'),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.purple.shade100,
                    side: BorderSide(color: Colors.purpleAccent, width: 3)),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('Task_app')
                      .doc(id)
                      .update({
                    'Task_name': Name_ctrl.text,
                    'Creation_date': Createdate_ctrl.text,
                    "Task_discription": Discription_ctrl.text,
                    "Task_duriation": Selected_item,
                    "Last_date": Lastdate_ctrl.text,
                  });
                  Name_ctrl.clear();
                  Createdate_ctrl.clear();
                  Discription_ctrl.clear();
                  Selected_item.toUpperCase();
                  Lastdate_ctrl.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))
          ],
        );
      },
    );
  }

  Future<void> Delete_task(String id) async {
    await FirebaseFirestore.instance.collection("Task_app").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Task_Add();
            },
          ));
        },
        backgroundColor: Colors.purpleAccent,
        child: Row(
          children: [
            Icon(Icons.add),
            Text(
              "Add",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              " Today's",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: Colors.purpleAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                " Tasks",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.pinkAccent),
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Task_app").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          final Task = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: Task.length,
            itemBuilder: (context, index) {
              final doc = Task[index];
              final Task_details = doc.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "${Task_details["Task_name"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink.shade900),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Creation Date : ${Task_details["Creation_date"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Wrap(
                            //     children: [
                            //       Text(
                            //         "${Task_details["Task_discription"] ?? ""}",
                            //         style: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.black),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Duriation : ${Task_details["Task_duriation"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Wrap(
                            //     children: [
                            //       Text(
                            //         "${Task_details["Last_date"] ?? ""}",
                            //         style: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold,
                            //             color: Colors.black),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Colors.purple.shade100,
                                          side: BorderSide(
                                              color: Colors.purpleAccent,
                                              width: 3)),
                                      onPressed: () {
                                        Update_task(
                                          doc.id,
                                          Task_details["Task_name"],
                                          Task_details["Creation_date"],
                                          Task_details["Task_discription"],
                                          Task_details["Task_duriation"],
                                          Task_details["Last_date"],
                                        );
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor:
                                              Colors.purple.shade100,
                                          side: BorderSide(
                                              color: Colors.purpleAccent,
                                              width: 3)),
                                      onPressed: () {
                                        Delete_task(doc.id);
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                SizedBox(
                                  height: 32,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          shape: CircleBorder(),
                                          backgroundColor:
                                              Colors.purple.shade100,
                                          side: BorderSide(
                                              color: Colors.purpleAccent,
                                              width: 3)),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Task_detail(
                                              id: doc.id,
                                            );
                                          },
                                        ));
                                      },
                                      child: Icon(Icons.arrow_forward_sharp)),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
