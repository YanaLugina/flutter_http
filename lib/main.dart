import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      home: MyHomePage(title: 'Networking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(

        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<http.Response> getData() async {
  var url =
  Uri.https('about.google', 'static/data/locations.json', {'q': '{https}'});
  return await http.get(url);
}

void loadData() {
  getData().then((response) {
    if(response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  })
  .catchError((error) {
    debugPrint(error.toString());
  });
}
