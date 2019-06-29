import "package:flutter/material.dart";

class LayoutExample extends StatefulWidget {
  @override
  _LayoutExample createState() => _LayoutExample();
}

class _LayoutExample extends State<LayoutExample> {
  bool _isFavourite = false;
  int _favouriteCount = 41;

  void toggleFaviourate() {
    setState(() {
      if (_isFavourite) {
        _favouriteCount = _favouriteCount - 1;
        _isFavourite = false;
      } else {
        _favouriteCount = _favouriteCount + 1;
        _isFavourite = true;
      }
    });
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Oeschinen Lake Campground",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(_isFavourite ? Icons.star : Icons.star_border),
            color: Colors.red,
            onPressed: toggleFaviourate,
          ),
          Text("$_favouriteCount")
        ],
      ),
    );
  }

  Column getButtonColumn(IconData icon, String lable) {
    return Column(
      children: <Widget>[
        Container(
          child: Icon(icon, color: Colors.blue),
          margin: EdgeInsets.only(bottom: 8),
        ),
        Text(lable)
      ],
    );
  }

  Widget buttonRow() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getButtonColumn(Icons.call, "CALL"),
        getButtonColumn(Icons.share, "SHARE"),
        getButtonColumn(Icons.near_me, "ROUTE")
      ],
    ));
  }

  Widget textSection() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
  }

  Widget getImage() {
    return Image.network(
      "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg",
      height: 240,
      width: 600,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[getImage(), title(), buttonRow(), textSection()],
    );
  }
}
