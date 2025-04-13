import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late int i;

  Stream<int> count() async* {
    for (i = 0; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text('StreamBuilder', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: StreamBuilder(
          stream: count(),
          initialData: 10,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.deepPurpleAccent);
            }
            if (snapshot.hasData) {
              return Text(
                "${snapshot.data}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text('Done counting!');
            }
          },
        ),
      ),
    );
  }
}
