import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream_builder/colors.dart';
import 'package:stream_builder/fruits_model.dart';
import 'package:stream_builder/tast_model.dart';

class FutureBuilderScreen extends StatefulWidget {
  FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  Future<Furits> getData() async {
    final documentSnapshot =
        await FirebaseFirestore.instance
            .collection("fruites")
            .doc("05g8uazidYONn8mJSNee")
            .get();

    debugPrint("querySnapshot of fruits: $documentSnapshot");

    return Furits.fromJson(documentSnapshot.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.amber,
        centerTitle: true,
        title: Text('Fruits', style: TextStyle(color: Colors.black)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Future<List<Furits>> data = getData();
          // debugPrint(data.toString());
        },
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final fruits = snapshot.data!;

            return ListTile(
              leading: Container(
                width: 100,
                height: 400,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.coral,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage(fruits.image!)),
                ),
              ),
              title: Text('${fruits.name}'),
            );
          }
        },
      ),
    );
  }
}

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:stream_builder/colors.dart';
// import 'package:stream_builder/fruits_model.dart';
// import 'package:stream_builder/tast_model.dart';

// class FutureBuilderScreen extends StatefulWidget {
//   FutureBuilderScreen({super.key});

//   @override
//   State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
// }

// class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
//   Future<List<Furits>> getData() async {
//     final querySnapshot =
//         await FirebaseFirestore.instance.collection("fruites").get();

//     debugPrint("querySnapshot of fruits: $querySnapshot");

//     return querySnapshot.docs.map((doc) {
//       debugPrint("doc.data(): ${doc.data()}");

//       return Furits.fromJson(doc.data());
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.amber,
//         centerTitle: true,
//         title: Text('Fruits', style: TextStyle(color: Colors.black)),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Future<List<Furits>> data = getData();
//           // debugPrint(data.toString());
//         },
//       ),
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(color: Colors.amber),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final fruits = snapshot.data!;

//             return ListView.builder(
//               itemCount: fruits.length,
//               itemBuilder: (context, index) {
//                 final fruit = fruits[index];
//                 return ListTile(
//                   leading: Container(
//                     width: 100,
//                     height: 400,
//                     margin: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: AppColors.coral,
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(image: NetworkImage(fruit.image!)),
//                     ),
//                   ),
//                   title: Text('${fruit.name}'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
