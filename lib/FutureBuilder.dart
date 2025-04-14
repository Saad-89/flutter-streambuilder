import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream_builder/colors.dart';
import 'package:stream_builder/tast_model.dart';

class FutureBuilderScreen extends StatefulWidget {
  FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    final data = await FirebaseFirestore.instance.collection('fruites').get();

    return data;
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
            final fruits = snapshot.data!.docs;

            return ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                final fruit = fruits[index];
                return ListTile(
                  leading: Container(
                    width: 100,
                    height: 400,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(fruit['image']),
                      ),
                    ),
                  ),
                  title: Text('${fruit['name']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
