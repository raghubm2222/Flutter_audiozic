import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Center(
        child: Container(
          height: 207,
          width: 151,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4.0),
                color: Colors.grey.shade100,
                blurRadius: 5.0,
                spreadRadius: 1.5,
              )
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Container(
            color: Colors.redAccent.shade100,
          ),
        ),
      ),
    );
  }
}
