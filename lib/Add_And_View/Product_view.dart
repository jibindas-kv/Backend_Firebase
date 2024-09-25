import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Add_And_View/Product_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_backend/Add_And_View/Product_update.dart';

class Product_view extends StatefulWidget {
  const Product_view({super.key});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Product_add();
          },));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        backgroundColor: Colors.black,
        title: Text("              Product View", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Product Details").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());

          }
          if(snapshot.hasError){
            return Text("$snapshot");
          }

        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 15,right: 15),
              child: Card(
            elevation: 4, // Add some shadow
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),),
                surfaceTintColor: Colors.red,

                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue.shade400, Colors.green.shade400],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("  Details : ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,))
                          ],
                        ),
                        SizedBox(width: 170,),
                        Column(
                          children: [
                            IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Product_update();
                              },));

                            }, icon: Icon(Icons.edit_note,color: Colors.black,))
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            IconButton(onPressed: () {

                            }, icon: Icon(CupertinoIcons.delete,color: Colors.black,))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
