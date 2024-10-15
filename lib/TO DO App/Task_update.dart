import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/TO%20DO%20App/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Task_update extends StatefulWidget {
  const Task_update({super.key, required this.id});
final id;
  @override
  State<Task_update> createState() => _Task_updateState();
}

class _Task_updateState extends State<Task_update> {

  @override
  initState() {
    super.initState();
    Getbyid();
  }
  String Selected_item = ' Select';
  String _radioValue = '';


  Future<void> Getbyid() async {
    DocumentSnapshot Task = await FirebaseFirestore.instance
        .collection("Task_app")
        .doc(widget.id)
        .get();
    if(Task.exists){
      Map<String, dynamic> Taskid = Task.data() as Map<String, dynamic>;
      setState(() {
        Name_ctrl.text=Taskid["Task_name"] ;
        Createdate_ctrl.text=Taskid["Creation_date"];
        Discription_ctrl.text=Taskid["Task_discription"];
        Selected_item=Taskid["Task_duriation"];
        Lastdate_ctrl.text=Taskid["Last_date"];
        _radioValue=Taskid["Task_type"];

      });
    }
  }

  Future<void> Update_task()async {
    FirebaseFirestore.instance.collection("Task_app").doc(widget.id).update({
      'Task_name' : Name_ctrl.text,
      'Creation_date' : Createdate_ctrl.text,
      'Task_discription' : Discription_ctrl.text,
      'Task_duriation' : Selected_item,
      'Last_date' : Lastdate_ctrl.text,
      'Task_type' : _radioValue,
    });
    
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("Task_app").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      final Task = snapshot.data?.docs ?? [];
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            TextField(
              controller: Name_ctrl,
              decoration: InputDecoration(
                  labelText: "Task Name",
                  focusColor: Colors.purple.shade100,
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.purple.shade100,
                  filled: true),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: Createdate_ctrl,
              decoration: InputDecoration(
                  labelText: "Creation Date",
                  focusColor: Colors.purple.shade100,
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.purple.shade100,
                  filled: true),
            ),
            SizedBox(height: 20,),
            TextField(
              minLines: 2,
              maxLines: 2,
              controller: Discription_ctrl,
              decoration: InputDecoration(
                labelText: "Task Discription",
                  focusColor: Colors.purple.shade100,
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.purple.shade100,
                  filled: true),
            ),
            SizedBox(height: 15,),
            Container(
              height: 50,
              width: 375,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.purple.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 13),
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
            ),
            SizedBox(height: 15,),
            TextField(
              controller: Lastdate_ctrl,
              decoration: InputDecoration(
                  labelText: "Task Discription",
                  focusColor: Colors.purple.shade100,
                  border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.purple.shade100,
                  filled: true),
            ),
            SizedBox(height: 15,),
            Container(
              height: 85,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.purple.shade100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        " Type Of Task",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            activeColor: Colors.black,
                            value: 'Personal',
                            groupValue: _radioValue,
                            onChanged: (String? value) {
                              setState(() {
                                _radioValue = value!;
                              });
                            },
                          ),
                          Text('Personal'),
                        ],
                      ), // Space between containers
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Work',
                            groupValue: _radioValue,
                            onChanged: (String? value) {
                              setState(() {
                                _radioValue = value!;
                              });
                            },
                          ),
                          Text('Work'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Others',
                            groupValue: _radioValue,
                            onChanged: (String? value) {
                              setState(() {
                                _radioValue = value!;
                              });
                            },
                          ),
                          Text('Others'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
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
              Update_task();
                
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Home();
              },));
            },
            ),

          ],
        ),
      );
    }
    ),
    );
  }
}
