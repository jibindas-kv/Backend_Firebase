import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Add_And_View/Product_view.dart';
import 'package:firebase_backend/Sorting/View_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Add_product extends StatefulWidget {
  const Add_product({super.key});

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  var Name_ctrl = TextEditingController();
  var Price_ctrl = TextEditingController();

  final formkey = GlobalKey<FormState>();
  String Selected_item = 'Select';
  final List<String> _product_type = [
    'Vegitables',
    'Fruits',
    'Grocery',
    'Select'
  ];

  Future<void> Add_product()async {
    FirebaseFirestore.instance.collection("Product_sort").add({
      "Product_name":Name_ctrl.text,
      "Product_category":Selected_item,
      "Product_price":Price_ctrl.text,
    });
    print("Data Added Successfully/////////////////");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return View_product();
      },
    ));
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
                style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
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
                Icon(Icons.add_shopping_cart_sharp,size: 100,color: Colors.green,),
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: DropdownButton<String>(

                        dropdownColor: Colors.white,
                        value: Selected_item,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 190),
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                          ),
                        ),
                        items: _product_type.map((String value) {
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
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: Price_ctrl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Any Value";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Price',
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
                SizedBox(height: 70,),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 90, right: 90),
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Add_product();

                      }
                    },
                    child: Container(
                      height: 50,
                      width: 390,
                      decoration: BoxDecoration(
                          color: Colors.green,
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
              ],
            ),
          ),
        )
    );
  }
}
