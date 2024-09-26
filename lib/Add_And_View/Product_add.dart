import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Add_And_View/Product_view.dart';
import 'package:flutter/material.dart';


class Product_add extends StatefulWidget {
  const Product_add({super.key});

  @override
  State<Product_add> createState() => _Product_addState();
}

class _Product_addState extends State<Product_add> {
  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();

  Future<void> Add_product()async{
    FirebaseFirestore.instance.collection("Product Details").add({
      "Product_name":Name_ctrl.text,
      "Product_discription":Details_ctrl.text
    });
    print("Data Added Successfully/////////////////");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Product_view();
      },
    ));
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            "Product Add",
            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Icon(Icons.add_shopping_cart_sharp,size: 100,color: Colors.blue,),
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
                  height: 40,
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
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Add_product();

                      } else {
                        _showSnackBar(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      )),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Product_view();
                        },
                      ));

                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                            'View Details',
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
