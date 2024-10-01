import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class View_details extends StatefulWidget {
  const View_details({super.key, required this.id});
  final id;

  @override
  State<View_details> createState() => _View_detailsState();
}

class _View_detailsState extends State<View_details> {
  Future<void> Getbyid() async {
    Product = await FirebaseFirestore.instance
        .collection("Product Details")
        .doc(widget.id)
        .get();
  }

  DocumentSnapshot? Product;
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
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                  Product!["Product_name"],
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.blue,
                    child: Text("Discription : ${Product!["Product_discription"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
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
