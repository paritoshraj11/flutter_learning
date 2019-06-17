import 'package:flutter/material.dart';
import '../appBar.dart';

class ManageProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppBar(),
      appBar: AppBar(
        title: Text("Manage Product"),
      ),
      body: Center(
        child: Text("Manage Product"),
      ),
    );
  }
}
