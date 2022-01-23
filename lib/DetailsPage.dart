import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {

  String src;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Hero(
            child: Image.network(src),
            tag: "tag"
        ),
      ),
    );
  }
  DetailsPage(this.src);
}
