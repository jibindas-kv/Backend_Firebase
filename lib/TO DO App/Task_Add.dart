import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/TO%20DO%20App/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';

class Task_Add extends StatefulWidget {
  const Task_Add({super.key});

  @override
  State<Task_Add> createState() => _Task_AddState();
}

class _Task_AddState extends State<Task_Add> {




  final List<String> _Duriation = [
    'Upto 12 Hour',
    'Upto 1 Day',
    'Upto 1 Week',
    'Upto 1 Month',
    'Upto 1 Year',
    'Select'
  ];

  String Selected_item = 'Select';

  var Name_ctrl = TextEditingController();
  var Createdate_ctrl = TextEditingController();
  var Discription_ctrl = TextEditingController();
  var Lastdate_ctrl=TextEditingController();

  final formkey = GlobalKey<FormState>();

  Future<void> Add_Task()async{
    FirebaseFirestore.instance.collection("Task_app").add({
      "Task_name":Name_ctrl.text,
      "Creation_date":Createdate_ctrl.text,
      "Task_discription":Discription_ctrl.text,
      "Task_duriation":Selected_item,
      "Last_date":Lastdate_ctrl.text,

    });
    print("Data Added Successfully/////////////////");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Home();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Text(
              " Add",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: Colors.purpleAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                " Task",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.pinkAccent),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: Name_ctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task Name Can't Empty";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Task Name",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.purple.shade100,
                        filled: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: Createdate_ctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task Name Can't Empty";
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Creation Date"),
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800),
                        hintText: "dd/mm/yy",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.purple.shade100,
                        filled: true),
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)))!;
                      var parsedDate = DateTime.parse(date.toIso8601String());
                      String convertedDate =
                          new DateFormat("dd-MM-yyyy").format(parsedDate);

                      Createdate_ctrl.text = convertedDate;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    minLines: 3,
                    maxLines: 10,
                    controller: Discription_ctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write About The Task";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Add About The Task",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.purple.shade100,
                        filled: true),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.purple.shade100,
                    ),
                    child: DropdownButton<String>(

                      dropdownColor: Colors.purple.shade100,
                      value: Selected_item,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 186),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ),
                      ),
                      items: _Duriation.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          Selected_item = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: Lastdate_ctrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Task Name Can't Empty";
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Last Date"),
                        labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800),
                        hintText: "dd/mm/yy",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusColor: Colors.purple.shade100,
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.purple.shade100,
                        filled: true),
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100)))!;
                      var parsedDate = DateTime.parse(date.toIso8601String());
                      String convertedDate =
                      new DateFormat("dd-MM-yyyy").format(parsedDate);

                      Lastdate_ctrl.text = convertedDate;
                    },
                  ),
                  SizedBox(height: 25,),
                  AnimatedButton(
                    height: 55,
                    width: 230,
                    text: 'Add To Your Task List',
                    textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    selectedBackgroundColor: Colors.purpleAccent,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    backgroundColor: Colors.black,
                    borderColor: Colors.purpleAccent,
                    borderRadius: 100,
                    borderWidth: 2, onPress: () {
                    if (formkey.currentState!.validate()) {
                      Add_Task();

                    }
                  },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

