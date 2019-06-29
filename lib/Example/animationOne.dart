import "package:flutter/material.dart";
import "dart:math";

class AnimationExample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationExample1();
  }
}

class _AnimationExample1 extends State<AnimationExample1> {
  double _height = 100;
  double _width = 100;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);
  bool _opacity = false;

  _startAnimation() {
    final random = Random();
    setState(() {
      _height = random.nextInt(300).toDouble();
      _width = random.nextInt(300).toDouble();
      _color = Color.fromARGB(
        255,
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
      );

      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Lzy"),
          ),
          body: Column(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity ? 1 : 0,
                duration: Duration(seconds: 3),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
              RaisedButton(
                child: Text("Opacity Toogle"),
                onPressed: () {
                  setState(() {
                    _opacity = !_opacity;
                  });
                },
              ),
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    height: _height,
                    width: _width,
                    decoration: BoxDecoration(
                        color: _color, borderRadius: _borderRadius),
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.star),
            onPressed: _startAnimation,
          )),
    );
  }
}
