import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('News Screen')
      ),
    );
  }

}
