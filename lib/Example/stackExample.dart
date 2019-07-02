import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: Text("Stack World")),
        body: StateApp(),
      ),
    );
  }
}

class StateApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateApp();
  }
}

class _StateApp extends State<StateApp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.holidify.com/images/bgImages/SHIMLA.jpg",
                  ))),
        ),
        Positioned(
          bottom: 48,
          left: 10,
          right: 10,
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Shimla",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        'Shimla, also known as Simla, is the capital and the largest city of the Indian state of Himachal Pradesh. Shimla is also a district which is bounded by the state of Uttarakhand in the south-east, districts of Mandi and Kullu in the north, Kinnaur in the east, Sirmaur in the south and Solan in the west.'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
