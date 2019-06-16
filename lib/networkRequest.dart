import "package:flutter/material.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;

class NetworkRequestExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NetworkRequestExample();
  }
}

class _NetworkRequestExample extends State<NetworkRequestExample> {
  Future getQuote() async {
    String url = "https://quotes.rest/qod.json";
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    print(">>>> gettting response of the api");
    print(response.body);
    print("after json decode of body");
    print(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          "Make Request",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: getQuote,
      ),
    );
  }
}
