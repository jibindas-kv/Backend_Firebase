import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_backend/Sorting/Add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class View_product extends StatefulWidget {
  const View_product({super.key});

  @override
  State<View_product> createState() => _View_productState();
}

class _View_productState extends State<View_product> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Add_product();
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
              child: Text("Catogary",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ),
          body: Column(
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 25),
                  child: Container(
                    width: 500,
                    height: 49,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                TabBar(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Fruits',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Vegtables',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Grocery',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Fruits(), // Call the first class
                    Vegtables(),
                    Grocery(),
                    // Call the second class
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class Fruits extends StatefulWidget {

  const Fruits({super.key});

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  Future<void> Delete_task(String id) async {
    await FirebaseFirestore.instance.collection("Product_sort").doc(id).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Product_sort").where("Product_category",isEqualTo: "Fruits").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),

                      dismissible: DismissiblePane(onDismissed: () {
                        Delete_task(doc.id);
                      }),

                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Delete_task(doc.id);

                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Name : ${product_details["Product_name"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Price : ${product_details["Product_price"] ?? ""}",
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

          },
        ));
  }
}


class Vegtables extends StatefulWidget {
  const Vegtables({super.key});

  @override
  State<Vegtables> createState() => _VegtablesState();
}

class _VegtablesState extends State<Vegtables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Product_sort").where("Product_category",isEqualTo: "Vegitables").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Name : ${product_details["Product_name"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Price : ${product_details["Product_price"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

          },
        )
    );
  }
}


class Grocery extends StatefulWidget {
  const Grocery({super.key});

  @override
  State<Grocery> createState() => _GroceryState();
}

class _GroceryState extends State<Grocery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Product_sort").where("Product_category",isEqualTo: "Grocery").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Name : ${product_details["Product_name"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  Text(
                                    "Price : ${product_details["Product_price"] ?? ""}",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

          },
        )
    );
  }
}

