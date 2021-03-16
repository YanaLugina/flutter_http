import 'package:flutter/material.dart';
import 'package:flutter_http/offices.dart';

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

  Future<OfficesList> officesList;

 @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
 /*    loadData();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<OfficesList>(
          future: officesList,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data.offices[index].name}'),
                      subtitle: Text('${snapshot.data.offices[index].address}'),
                      leading: Image.network('${snapshot.data.offices[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                }
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*Future<http.Response> getData() async {
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
}*/
