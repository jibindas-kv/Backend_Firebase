import 'package:firebase_backend/Add_And_View/Product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product_update extends StatefulWidget {
  const Product_update({super.key});

  @override
  State<Product_update> createState() => _Product_updateState();
}

class _Product_updateState extends State<Product_update> {
  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();

  Future<void> Add_data_sp() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setString("Name", Name_ctrl.text);
    data.setString("Details", Details_ctrl.text);
    print(
        "Added Successfully/////////////////////////////////////////////////////");
  }

  final formkey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Enter The Values'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Product_view();
            },));
          }, icon: Icon(Icons.arrow_back_ios,color: Colors.green,),),
          backgroundColor: Colors.black,
          title: Text(
            "            Product Update",
            style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Icon(Icons.update,size: 100,color: Colors.green,),
                SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Name_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Name',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Details_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Details',
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        print("Details Submitted");
                        Add_data_sp();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Product_view();
                          },
                        ));
                      } else {
                        _showSnackBar(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.green.shade400,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
