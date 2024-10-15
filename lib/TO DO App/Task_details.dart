import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task_detail extends StatefulWidget {
  const Task_detail({super.key, required this.id});
  final id;

  @override
  State<Task_detail> createState() => _Task_detailState();
}

class _Task_detailState extends State<Task_detail> {
  Future<void> Getbyid() async {
    Task = await FirebaseFirestore.instance
        .collection("Task_app")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? Task;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getbyid(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return CircularProgressIndicator(color: Colors.blue,);
        }
        if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            toolbarHeight: 70,
            title: Center(
              child: Text(
                Task!["Task_name"],
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 35),
              ),
            ),
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text("Task Create Date : ",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text("${Task!["Creation_date"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text("About The Task : ",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text("${Task!["Task_discription"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text("Task Duriation : ",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text("${Task!["Task_duriation"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text("Last Date : ",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text("${Task!["Last_date"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text("Type Of Task : ",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    Text("${Task!["Task_type"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                            ],),
                          )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      },
    );
  }
}
