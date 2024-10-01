import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Add_And_View/Product_add.dart';
import 'package:firebase_backend/Add_And_View/View_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product_view extends StatefulWidget {
  const Product_view({super.key});

  @override
  State<Product_view> createState() => _Product_viewState();
}

class _Product_viewState extends State<Product_view> {
  Future<void> _updateProduct(
      String id, String name, String description) async {
    _nameController.text = name;
    _descriptionController.text = description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Product Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Product Details')
                    .doc(id)
                    .update({
                  'Product_name': _nameController.text,
                  'Product_discription': _descriptionController.text,
                });
                _nameController.clear();
                _descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> Delete_product(String id) async {
    await FirebaseFirestore.instance
        .collection("Product Details")
        .doc(id)
        .delete();
  }

  var Name_ctrl = TextEditingController();
  var Details_ctrl = TextEditingController();
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Product_add();
            },
          ));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Product View",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Product Details")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            final Product = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: Product.length,
              itemBuilder: (context, index) {
                final doc = Product[index];
                final product_details = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return View_details(
                          id:doc.id
                        );
                      },));
                    },

                    child: Card(
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
                        child: ListTile(
                          title: Text(
                            "Name : ${product_details["Product_name"] ?? ""}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            "Details  : ${product_details["Product_discription"] ?? ""}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          trailing: Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  _updateProduct(
                                      doc.id,
                                      product_details["Product_name"],
                                      product_details["Product_discription"]);
                                },
                                icon: Icon(
                                  CupertinoIcons.pen,
                                  color: Colors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  Delete_product(doc.id);
                                },
                                icon: Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.black,
                                ))
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
